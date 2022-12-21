//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct RemoteNotificationsClient {
    public var isRegistered: @Sendable () async -> Bool
    public var register: @Sendable () async -> Void
    public var unregister: @Sendable () async -> Void
}
