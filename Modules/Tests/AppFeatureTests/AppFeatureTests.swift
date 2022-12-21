//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import XCTest

@testable import AppFeature

import ComposableArchitecture
import AppDelegateClient

@MainActor
final class AppFeatureTests: XCTestCase {

//    func test_appLaunch() async {
//        let store = TestStore(initialState: AppState(), reducer: CompositionRoot())
//        let lifeCycle = AsyncStream<LifeCycleEvent>.streamWithContinuation()
//
//        store.dependencies.appLifeCycle.stream = { lifeCycle.stream }
//
//        // Bootstrap is action sent when intializing appliciation.
//        await store.send(.bootstrap)
//
//        lifeCycle.continuation.yield(.didFinishLaunching)
//
//        await store.receive(AppAction.lifeCycle(.didFinishLaunching))
//
//        lifeCycle.continuation.finish()
//        await store.finish()
//    }
//
//    func test_connectsToRealtimeMessaging() async {
//        let store = TestStore(
//            initialState: AppState(),
//            reducer: CompositionRoot()
//        )
//        store.dependencies.realtimeMessagingClient.connect = { .finished }
//        store.dependencies.realtimeMessagingClient.handleDeviceRegistration = { _ in }
//
//        await store.send(.appDelegate(.didRegisterForRemoteNotifications(.success(Data("deadbeef".utf8)))))
//    }
}
