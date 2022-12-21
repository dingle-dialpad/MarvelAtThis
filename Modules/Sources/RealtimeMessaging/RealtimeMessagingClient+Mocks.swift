//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture
import XCTestDynamicOverlay

extension RealtimeMessagingClient: TestDependencyKey {

    static public let previewValue = RealtimeMessagingClient(
        connect: { .finished },
        registerDeviceToken: { _ in },
        subscribe: { _ in .finished }
    )

    static public let testValue = RealtimeMessagingClient(
        connect: unimplemented("\(Self.self).connect", placeholder: .finished),
        registerDeviceToken: unimplemented("\(Self.self).handleDeviceRegistration"),
        subscribe: unimplemented("\(Self.self).subscribe", placeholder: .finished)
    )
}
