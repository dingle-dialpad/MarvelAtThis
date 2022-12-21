//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture

extension DependencyValues {
    public var realtimeMessagingClient: RealtimeMessagingClient {
        get { self[RealtimeMessagingClient.self] }
        set { self[RealtimeMessagingClient.self] = newValue }
    }
}

public struct RealtimeMessagingClient {
    public var connect: @Sendable () async -> AsyncStream<Action>
    public var registerDeviceToken: @Sendable (Data) async -> Void
    public var subscribe: @Sendable (Channel) async -> AsyncStream<Message>

    public init(
        connect: @Sendable @escaping () async -> AsyncStream<Action>,
        registerDeviceToken: @Sendable @escaping (Data) async -> Void,
        subscribe: @Sendable @escaping (Channel) async -> AsyncStream<Message>
    ) {
        self.connect = connect
        self.registerDeviceToken = registerDeviceToken
        self.subscribe = subscribe
    }

    public enum Action: Equatable {
        case didActivate
        case didDeactivate
    }

    public struct Message: Equatable {
        public let name: String
        public let data: Data

        public init(name: String, data: Data) {
            self.name = name
            self.data = data
        }
    }
}

public enum Channel: String {
    case characters = "Marvelous"
    case dingleTest = "Dingle"
}
