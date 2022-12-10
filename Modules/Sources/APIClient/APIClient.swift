//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
import SharedModels

/// APIClient interface.
public struct APIClient {
    public var resolve: @Sendable (Route) async throws -> URLRequest
    public var dispatch: @Sendable (URLRequest) async throws -> APIResponse
    public internal(set) var setAuthentication: @Sendable (Authentication) async -> Void
    public internal(set) var setBaseURL: @Sendable (URL) async -> Void

    public init(
        resolve: @Sendable @escaping (Route) async throws -> URLRequest,
        dispatch: @Sendable @escaping (URLRequest) async throws -> APIResponse,
        setAuthentication: @Sendable @escaping (Authentication) async -> Void,
        setBaseURL: @Sendable @escaping (URL) async -> Void
    ) {
        self.resolve = resolve
        self.dispatch = dispatch
        self.setAuthentication = setAuthentication
        self.setBaseURL = setBaseURL
    }

}

// MARK: - JSON
extension APIClient {

    private static let RFC3339DateFormatter: DateFormatter = {
        //"2013-06-28T16:31:24-0400"
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()

    private static let eventDateFormatter: DateFormatter = {
        //"1989-12-10 00:00:00"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyy-MM-dd HH:mm:ss"
        return formatter
    }()

    public static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            if let date = RFC3339DateFormatter.date(from: dateString) {
                return date
            } else if let date = eventDateFormatter.date(from: dateString) {
                return date
            } else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: container.codingPath,
                        debugDescription: "Failed to decode date for dateString \(dateString)"
                    )
                )
            }
        }
        return decoder
    }()

    public static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(RFC3339DateFormatter)
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        return encoder
    }()

    func request<A>(route: Route) async throws -> A where A: Decodable {
        let request = try await self.resolve(route)
        let response = try await self.dispatch(request)
        return try Self.decoder.decode(A.self, from: response.data)
    }

    func request(route: Route) async throws {
        let request = try await self.resolve(route)
        _ = try await self.dispatch(request)
    }
}
