//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct MarvelCharacter: Codable, Identifiable, Equatable {
    public let id: Int
    public var name: String
    public var bio: String
    public var lastModified: Date
    public var canonicalURL: URL
    public var urls: [Annotated<URL>]
    public var thumbnail: ImageRef
    public var comics: ResourceList<Comic>
    public var stories: ResourceList<Story>
    public var events: ResourceList<CosmicEvent>
    public var series: ResourceList<Series>

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case bio = "description"
        case lastModified = "modified"
        case canonicalURL = "resourceURI"
        case urls
        case thumbnail
        case comics
        case stories
        case events
        case series
    }

    public init(
        id: Int,
        name: String,
        bio: String,
        lastModified: Date,
        canonicalURL: URL,
        urls: [Annotated<URL>],
        thumbnail: ImageRef,
        comics: ResourceList<Comic>,
        stories: ResourceList<Story>,
        events: ResourceList<CosmicEvent>,
        series: ResourceList<Series>
    ) {
        self.id = id
        self.name = name
        self.bio = bio
        self.lastModified = lastModified
        self.canonicalURL = canonicalURL
        self.urls = urls
        self.thumbnail = thumbnail
        self.comics = comics
        self.stories = stories
        self.events = events
        self.series = series
    }
}

