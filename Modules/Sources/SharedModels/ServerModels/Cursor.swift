//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct Cursor: Codable, Equatable {
    public let offset: Int
    public let limit: Int

    public init(offset: Int, limit: Int) {
        self.offset = offset
        self.limit = limit
    }
}
