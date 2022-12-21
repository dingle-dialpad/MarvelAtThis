//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
import SharedModels

public enum Route: Encodable, Equatable {
    case characters(Characters)
    case events(Events)

    public enum Characters: Equatable {
        case fetchCharacters(Cursor?)
    }

    public enum Events: Equatable {
        case fetchEvents(Cursor?)
    }
}

extension Route {
    public var path: String {
        switch self {
        case .characters(.fetchCharacters):
            return "characters"
        case .events(.fetchEvents):
            return "events"
        }
    }
}

extension Route.Events {
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .fetchEvents(let cursor):
            var container = encoder.container(keyedBy: Route.ParameterKey.self)
            try container.encodeIfPresent(cursor?.limit, forKey: .limit)
            try container.encodeIfPresent(cursor?.offset, forKey: .offset)
        }
    }
}

extension Route {

    public func url(relativeTo baseURL: URL) -> URL {
        if #available(iOS 16.0, *) {
            return baseURL.appending(path: path)
        } else {
            return URL(string: path, relativeTo: baseURL)!
        }
    }
}

extension Route {

    public func parameters() throws -> [String: Any] {
        let encoded = try APIClient.encoder.encode(self)
        let jsonParameters = try JSONSerialization.jsonObject(
            with: encoded,
            options: [.fragmentsAllowed]
        )
        return jsonParameters as? [String: Any] ?? [:]
    }
}
