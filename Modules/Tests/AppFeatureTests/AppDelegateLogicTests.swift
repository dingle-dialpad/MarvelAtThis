//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import XCTest
@testable import AppFeature

import ComposableArchitecture
import RealtimeMessaging


@MainActor
public final class AppDelegateLogicTests: XCTestCase {

    func test_subscribesToRealtimeMessagingChannelUponAppStartup() async {
        let didRegisterForRemoteNotifications = ActorIsolated(false)
        let didRegisterForUserNotifications = ActorIsolated(false)
        let tokenData = Data("My_Marvelous_Token_Data".utf8)

        let realtimeActions = AsyncStream<RealtimeMessagingClient.Action>.streamWithContinuation()

        let store = TestStore(initialState: AppSettings(), reducer: AppDelegateLogic())

        store.dependencies.realtimeMessagingClient.connect = { realtimeActions.stream }
        store.dependencies.realtimeMessagingClient.registerDeviceToken = { _ in }
        store.dependencies.userNotifications.register = {
            await didRegisterForUserNotifications.setValue(true)
            return true
        }
        store.dependencies.remoteNotifications.register = {
            await didRegisterForRemoteNotifications.setValue(true)
        }


        await store.send(.lifeCycle(.didFinishLaunching))

        // Confirm remote notification registration
        await didRegisterForRemoteNotifications.withValue { XCTAssertTrue($0) }
        await didRegisterForUserNotifications.withValue { XCTAssertTrue($0) }

        // Simulate successful registration for remote notificaitons
        await store.send(.lifeCycle(.didRegisterForRemoteNotifications(.success(tokenData)))) {
            $0.deviceToken = "4D795F4D617276656C6F75735F546F6B656E5F44617461"
        }

        // End the long running connection to the realtime messaging client
        realtimeActions.continuation.finish()
        await store.finish()
    }


}
