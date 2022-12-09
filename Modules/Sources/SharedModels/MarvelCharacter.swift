//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct MarvelCharacter {
    public let id: Int
    public var name: String
    public var bio: String
    public var lastModified: Date
    public var canonicalURL: URL
    public var urls: [MarvelURL]
    public var thumbnail: ImageRef
    public var comics: ResourceList<Comic>
    public var stories: ResourceList<Story>
    public var events: ResourceList<CosmicEvent>
    public var series: ResourceList<Series>
}


