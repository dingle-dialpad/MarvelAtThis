//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct Series: Codable, Identifiable, Equatable {
    public let id: Int
    public var title: String
    public var summary: String
    public var cannonicalURL: URL
    public var urls: [Annotated<URL>]
    public var startYear: Int
    public var endYear: Int
    public var rating: String
    public var lastModified: Date
    public var thumbnail: ImageRef
    public var comics: ResourceList<Comic>
    public var stories: ResourceList<Story>
    public var events: ResourceList<CosmicEvent>
    public var characters: ResourceList<MarvelCharacter>
    public var creators: ResourceList<Creator>
    public var next: ResourceRef<Series>
    public var previous: ResourceRef<Series>
}
