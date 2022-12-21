//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture

extension DependencyValues {
    public var userNotifications: UserNotificationsClient {
        get { self[UserNotificationsClient.self] }
        set { self[UserNotificationsClient.self] = newValue }
    }
}

public struct UserNotificationsClient {
    public var register: @Sendable () async throws -> Bool

    public init(
        register: @Sendable @escaping () async throws -> Bool
    ) {
        self.register = register
    }
}

