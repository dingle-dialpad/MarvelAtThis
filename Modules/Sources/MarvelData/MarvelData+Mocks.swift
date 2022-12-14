//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture
import XCTestDynamicOverlay
import SharedModels

extension MarvelDataClient: TestDependencyKey {

    public static let testValue = MarvelDataClient(
        connect: unimplemented("\(Self.self).connect", placeholder: .finished),
        subscribe: unimplemented("\(Self.self).subscribe", placeholder: .finished)
    )

    public static let previewValue = MarvelDataClient(
        connect: { _ in .finished },
        subscribe: { _, _ in .finished }
    )
}
