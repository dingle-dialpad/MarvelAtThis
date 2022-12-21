//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import UIKit
import Dependencies
import XCTestDynamicOverlay

extension DependencyValues {

    public var asyncImage: AsyncImage {
        get { self[AsyncImage.self] }
        set { self[AsyncImage.self] = newValue }
    }

}

public struct AsyncImage {

    public var setImage: (URL, UIImageView) -> Void
}

extension AsyncImage: TestDependencyKey {

    static public var previewValue = AsyncImage { _, imageView in
        imageView.backgroundColor = .orange
    }

    static public var testValue = AsyncImage(
        setImage: unimplemented("\(Self.self).setImage")
    )
}
