//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import UIKit
import ComposableArchitecture

extension RemoteNotificationsClient: DependencyKey {

    public static let liveValue = RemoteNotificationsClient(
        isRegistered: { await UIApplication.shared.isRegisteredForRemoteNotifications },
        register: { await UIApplication.shared.registerForRemoteNotifications() },
        unregister: { await UIApplication.shared.unregisterForRemoteNotifications() }
    )
}
