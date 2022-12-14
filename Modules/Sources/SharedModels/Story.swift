//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct Story: Codable, Identifiable, Equatable {
    public let id: Int
    public var title: String
    public var summary: String
    public var canonicalURL: URL
    public var type: String
    public var lastModified: Date
    public var thumbnail: ImageRef?
    public var comics: ResourceList<Comic>
    public var series: ResourceList<Series>
    public var events: ResourceList<CosmicEvent>
    public var characters: ResourceList<MarvelCharacter>
    public var creators: ResourceList<Creator>
    public var originalIssue: ResourceRef<Comic>

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case summary = "description"
        case canonicalURL = "resourceURI"
        case type
        case lastModified = "modified"
        case thumbnail
        case comics
        case series
        case events
        case characters
        case creators
        case originalIssue
    }
}
