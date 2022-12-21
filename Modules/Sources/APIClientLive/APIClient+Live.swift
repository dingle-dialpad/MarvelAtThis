//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

@_exported import APIClient
import Dependencies
import Foundation
import CryptoKit

extension APIClient: DependencyKey {

    public static var liveValue: Self = {
        let api = NetworkingActor()
        return APIClient(
            resolve: { try await api.resolve(route: $0) },
            dispatch: { try await api.dispatch(request: $0) },
            setAuthentication: { await api.setAuthentication($0) },
            setBaseURL: { await api.setBaseURL($0) }
        )
    }()

}

private actor NetworkingActor {
    var endpointFactory = EndpointFactory()
    var authentication: Authentication?

    init() {
    }

    func setAuthentication(_ authentication: Authentication?) async {
        self.authentication = authentication
    }

    func setBaseURL(_ url: URL) async {
        await self.endpointFactory.setBaseURL(url)
    }

    func resolve(route: Route) async throws -> URLRequest {
        try await self.endpointFactory.resolveRoute(route)
    }

    func dispatch(request: URLRequest) async throws -> APIResponse {
        var request = request

        let timestamp = Date.now.timeIntervalSince1970
        let publicKey = "746e3520c1b5a62cb96c269427d784a3"
        let privateKey = ""
        let auth = "\(timestamp)\(privateKey)\(publicKey)".data(using: .utf8)
        let hash = Insecure.MD5.hash(data: auth!)
            .map { String(format: "%02hhx", $0) }
            .joined()

        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "ts", value: "\(timestamp)"),
            URLQueryItem(name: "apikey", value: "\(publicKey)"),
            URLQueryItem(name: "hash", value: "\(hash)")
        ]
        var urlComponents = URLComponents(
            url: request.url!,
            resolvingAgainstBaseURL: false
        )!
        let currentQueryItems = urlComponents.queryItems ?? []
        urlComponents.queryItems = currentQueryItems + queryItems

        request.url = urlComponents.url!

        let result = try await URLSession.shared.data(from: request.url!)
        return APIResponse(data: result.0, metadata: result.1)
    }

}

private actor EndpointFactory {
    var baseURL = URL(string: "http://gateway.marvel.com/v1/public")!

    func resolveRoute(_ route: Route) throws -> URLRequest {
        let url = route.url(relativeTo: baseURL)
        let parameters = try route.parameters()
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = parameters.map {
            URLQueryItem(name: $0.key, value: "\($0.value)")
        }
        return URLRequest(url: urlComponents.url!)
    }

    func setBaseURL(_ url: URL) async {
        self.baseURL = url
    }
}
