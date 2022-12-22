//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct CosmicEvent: Codable, Identifiable, Equatable {
    public let id: Int
    public var title: String
    public var summary: String
    public var canonicalURL: URL
    public var urls: [Annotated<URL>]
    public var lastModified: Date
    public var start: Date? 
    public var end: Date?
    public var thumbnail: ImageRef
    public var comics: ResourceList<Comic>
    public var stories: ResourceList<Story>
    public var series: ResourceList<Series>
    public var characters: ResourceList<MarvelCharacter>
    public var creators: ResourceList<Creator>
    public var next: ResourceRef<CosmicEvent>?
    public var previous: ResourceRef<CosmicEvent>?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case summary = "description"
        case canonicalURL = "resourceURI"
        case urls
        case lastModified = "modified"
        case start
        case end
        case thumbnail
        case comics
        case stories
        case series
        case characters
        case creators
        case next
        case previous
    }

    public init(
        id: Int,
        title: String,
        summary: String,
        canonicalURL: URL,
        urls: [Annotated<URL>],
        lastModified: Date,
        start: Date? = nil,
        end: Date? = nil,
        thumbnail: ImageRef,
        comics: ResourceList<Comic>,
        stories: ResourceList<Story>,
        series: ResourceList<Series>,
        characters: ResourceList<MarvelCharacter>,
        creators: ResourceList<Creator>,
        next: ResourceRef<CosmicEvent>? = nil,
        previous: ResourceRef<CosmicEvent>? = nil
    ) {
        self.id = id
        self.title = title
        self.summary = summary
        self.canonicalURL = canonicalURL
        self.urls = urls
        self.lastModified = lastModified
        self.start = start
        self.end = end
        self.thumbnail = thumbnail
        self.comics = comics
        self.stories = stories
        self.series = series
        self.characters = characters
        self.creators = creators
        self.next = next
        self.previous = previous
    }
}
