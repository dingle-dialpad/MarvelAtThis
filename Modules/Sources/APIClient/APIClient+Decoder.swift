//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
import Rebar

extension JSONDecoder.DateDecodingStrategy {
    static let marvelAPI = Self.first(using: [.RFC3339, .eventDateTime])
}

extension APIClient {
    public typealias Input = Data

    public static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .marvelAPI
        return decoder
    }()
}
