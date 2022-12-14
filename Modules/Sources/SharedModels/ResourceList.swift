//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct ResourceList<A>: Codable, Equatable {
    public var available: Int
    public var collectionURL: URL
    public var items: [ResourceRef<A>]
    public var returned: Int

    enum CodingKeys: String, CodingKey {
        case available
        case collectionURL = "collectionURI"
        case items
        case returned
    }
}
