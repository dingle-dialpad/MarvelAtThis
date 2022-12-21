//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

extension Route {
    struct ParameterKey: CodingKey {
        init?(intValue: Int) { return nil }
        init(stringValue: String) { self.stringValue = stringValue }

        let stringValue: String
        var intValue: Int? { nil }

        static let limit = ParameterKey(stringValue: "limit")
        static let offset = ParameterKey(stringValue: "offset")
    }
}

extension Route {
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .characters(let route): try route.encode(to: encoder)
        case .events(let route): try route.encode(to: encoder)
        }
    }
}

extension Route.Characters {
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .fetchCharacters(let cursor):
            var container = encoder.container(keyedBy: Route.ParameterKey.self)
            try container.encodeIfPresent(cursor?.limit, forKey: .limit)
            try container.encodeIfPresent(cursor?.offset, forKey: .offset)
        }
    }
}
