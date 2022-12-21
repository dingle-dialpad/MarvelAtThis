//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
import SharedModels

public struct APIPayload<A>: Equatable where A: Codable, A: Equatable {
    public let metadata: Metadata
    public let data: Results

    public struct Metadata: Codable, Equatable {
        public let code: Int
        public let status: String
        public let etag: String
    }

    public struct Results: Codable, Equatable {
        public let cursor: Cursor
        public let total: Int
        public let count: Int
        public let results: [A]
    }
}

extension APIPayload: Decodable where A: Decodable {
    enum DecodingKeys: String, CodingKey {
        case data
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        let dataDecoder = try container.superDecoder(forKey: .data)
        self.metadata = try Metadata(from: decoder)
        self.data = try Results(from: dataDecoder)
    }
}

extension APIPayload: Encodable where A: Encodable {
    enum EncodingKeys: String, CodingKey {
        case metadata
        case data
    }
}

extension APIPayload.Results {

    enum CodingKeys: String, CodingKey {
        case count
        case cursor
        case results
        case total
    }

    public init(from decoder: Decoder) throws {
        self.cursor = try Cursor(from: decoder)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.total = try container.decode(Int.self, forKey: .total)
        self.results = try container.decode([A].self, forKey: .results)
    }
}
