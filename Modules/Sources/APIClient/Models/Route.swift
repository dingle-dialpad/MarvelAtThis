//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
import SharedModels

public enum Route: Encodable, Equatable {
    case temp
}

extension Route {
    public var path: String {
        switch self {
        case .temp: return ""
        }
    }
}

extension Route {
    struct ParameterKey: CodingKey {
        init?(intValue: Int) { return nil }
        init(stringValue: String) { self.stringValue = stringValue }

        let stringValue: String
        var intValue: Int? { nil }
    }
}

extension Route {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
