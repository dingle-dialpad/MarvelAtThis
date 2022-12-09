//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct APIPayload<A>: Codable where A: Codable {
    public let metadata: Metadata
    public let data: Results<A>

    public struct Metadata {
        public let code: Int
        public let status: String
        public let etag: String
    }

    public struct Results<A> {
        public let offset: Int
        public let limit: Int
        public let total: Int
        public let count: Int
        public let results: [A]
    }
}

extension APIPayload {
    enum CodingKeys: String, CodingKey {
        case code
        case data
        case etag
        case status
    }

    enum NestedKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: NestedKeys.self, forKey: .data)
        self.metadata = Metadata(
            code: try container.decode(Int.self, forKey: .code),
            status: try container.decode(String.self, forKey: .status),
            etag: try container.decode(String.self, forKey: .etag)
        )
        self.data = Results(
            offset: try nestedContainer.decode(Int.self, forKey: .offset),
            limit: try nestedContainer.decode(Int.self, forKey: .limit),
            total: try nestedContainer.decode(Int.self, forKey: .total),
            count: try nestedContainer.decode(Int.self, forKey: .count),
            results: try nestedContainer.decode([A].self, forKey: .results)
        )
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var nestedContainer = container.nestedContainer(keyedBy: NestedKeys.self, forKey: .data)

        try container.encode(metadata.code, forKey: .code)
        try container.encode(metadata.etag, forKey: .etag)
        try container.encode(metadata.status, forKey: .status)
        try nestedContainer.encode(data.offset, forKey: .offset)
        try nestedContainer.encode(data.limit, forKey: .limit)
        try nestedContainer.encode(data.total, forKey: .total)
        try nestedContainer.encode(data.count, forKey: .count)
        try nestedContainer.encode(data.results, forKey: .results)
    }
}
