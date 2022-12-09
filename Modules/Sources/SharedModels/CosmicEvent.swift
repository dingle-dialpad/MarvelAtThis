//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct CosmicEvent: Codable {
    public let id: Int
    public var title: String
    public var summary: String
    public var cannonicalURL: URL
    public var urls: [Annotated<URL>]
    public var lastModified: Date
    public var start: Date
    public var end: Date
    public var thumbnail: ImageRef
    public var comics: ResourceList<Comic>
    public var stories: ResourceList<Story>
    public var series: ResourceList<Series>
    public var characters: ResourceList<MarvelCharacter>
    public var creators: ResourceList<Creator>
    public var next: ResourceRef<CosmicEvent>
    public var previous: ResourceRef<CosmicEvent>
}
