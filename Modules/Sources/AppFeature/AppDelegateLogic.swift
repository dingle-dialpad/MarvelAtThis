//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture
import AppDelegateClient

import RealtimeMessaging
import RemoteNotificationsClient
import UserNotifications

public struct AppDelegateLogic: ReducerProtocol {
    public typealias State = AppSettings
    public typealias Action = AppAction

    @Dependency(\.realtimeMessagingClient) var realtimeMessaging
    @Dependency(\.remoteNotifications) var remoteNotifications
    @Dependency(\.userNotifications) var userNotifications

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .lifeCycle(.didFinishLaunching):
                return .run { send in
                    await withThrowingTaskGroup(of: Void.self) { group in
                        group.addTask {
                            for await action in await self.realtimeMessaging.connect() {
                                await send(.realtimeMessaging(action))
                            }
                        }

                        group.addTask {
                            _ = try await self.userNotifications.register()
                            await self.remoteNotifications.register()
                        }
                    }
                }

            case .lifeCycle(.didRegisterForRemoteNotifications(.success(let tokenData))):
                state.deviceToken = tokenData.reduce("", {$0 + String(format: "%02X", $1)})
                return .fireAndForget {
                    await realtimeMessaging.registerDeviceToken(tokenData)
                }


            case .realtimeMessaging(.didActivate):
                return .run { send in
                    for await message in await realtimeMessaging.subscribe(.dingleTest) {
                        await send(.characterMessage(message))
                    }
                }

            case .realtimeMessaging(.didDeactivate):
                return .none

            case .userNotifications:
                return .none

            default: return .none
            }
        }
    }
}

public struct AppSettings: Equatable {
    var deviceToken: String = ""

}
