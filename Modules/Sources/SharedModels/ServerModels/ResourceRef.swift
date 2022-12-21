//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct ResourceRef<A>: Codable, Equatable {
    public var uri: String
    public var name: String

    enum CodingKeys: String, CodingKey {
        case uri = "resourceURI"
        case name
    }

    public init(uri: String, name: String) {
        self.uri = uri
        self.name = name
    }
}

extension ResourceRef where A: Identifiable, A.ID == Int {

    public var id: Int? {
        URL(string: uri)
            .map(\.lastPathComponent)
            .flatMap(Int.init)
    }
}
