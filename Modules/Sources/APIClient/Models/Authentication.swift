//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct Authentication {
    public let publicKey: String

    public init(publicKey: String) {
        self.publicKey = publicKey
    }
}
