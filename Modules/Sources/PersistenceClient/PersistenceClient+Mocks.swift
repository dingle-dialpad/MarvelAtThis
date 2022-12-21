//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture
import XCTestDynamicOverlay

extension PersistenceClient: TestDependencyKey {

    public static let previewValue = PersistenceClient(
        insertFavorite: { _ in }
    )

    public static let testValue = PersistenceClient(
        insertFavorite: unimplemented("\(Self.self).insertFavorite")
    )
}
