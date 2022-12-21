//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture
import XCTestDynamicOverlay

extension DependencyValues {
    public var remoteNotifications: RemoteNotificationsClient {
        get { self[RemoteNotificationsClient.self] }
        set { self[RemoteNotificationsClient.self] = newValue }
    }
}

extension RemoteNotificationsClient: TestDependencyKey {

    static public let previewValue = RemoteNotificationsClient(
        isRegistered: { true },
        register: { },
        unregister: { }
    )

    static public let testValue = RemoteNotificationsClient(
        isRegistered: unimplemented("\(Self.self).isRegistered", placeholder: false),
        register: unimplemented("\(Self.self).register"),
        unregister: unimplemented("\(Self.self).unregister")
    )
}
