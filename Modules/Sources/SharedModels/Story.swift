//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct Story: Codable {
    public let id: Int
    public var title: String
    public var summary: String
    public var cannonicalURL: URL
    public var type: String
    public var lastModified: Date
    public var thumbnail: ImageRef
    public var comics: ResourceList<Comic>
    public var series: ResourceList<Series>
    public var events: ResourceList<CosmicEvent>
    public var chraracters: ResourceList<MarvelCharacter>
    public var creators: ResourceList<Creator>
    public var originalIssue: ResourceRef<Comic>
}
