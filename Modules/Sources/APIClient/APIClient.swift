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
