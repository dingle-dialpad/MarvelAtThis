//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct ResourceRef<A>: Codable {
    public var uri: String
    public var name: String

    enum CodingKeys: String, CodingKey {
        case uri = "resourceURI"
        case name
    }
}
