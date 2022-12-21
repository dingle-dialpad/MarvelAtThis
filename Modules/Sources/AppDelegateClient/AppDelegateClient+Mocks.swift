//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
import Dependencies
import XCTestDynamicOverlay

extension AppDelegateClient: TestDependencyKey {

    public static let previewValue = AppDelegateClient(
        stream: { .finished }
    )

    public static let testValue = AppDelegateClient(
        stream: unimplemented("\(Self.self).stream", placeholder: .finished)
    )
}
