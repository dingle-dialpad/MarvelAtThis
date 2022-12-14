//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct ImageRef: Codable, Equatable {
    public let path: String
    public let fileExtension: String

    public var url: URL? {
        URL(string: path)
    }

    enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }

    public init(path: String, fileExtension: String) {
        self.path = path
        self.fileExtension = fileExtension
    }
}

