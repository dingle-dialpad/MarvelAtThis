//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import ComposableArchitecture
import XCTestDynamicOverlay

extension UserNotificationsClient: TestDependencyKey {

    public static let previewValue = UserNotificationsClient(
        register: { true }
    )

    public static let testValue = UserNotificationsClient(
        register: unimplemented("\(Self.self).register", placeholder: false)
    )
        
}
