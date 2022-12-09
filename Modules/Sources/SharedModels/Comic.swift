//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public typealias Price = Float

public struct Comic: Codable {
    public let id: Int
    public let digitalID: Int
    public var title: String
    public var issueNumber: Int
    public var variantInfo: String
    public var summary: String
    public var lastModified: Date
    public var isbn: String
    public var upc: String
    public var diamondCode: String
    public var eanBarcode: String
    public var issnBarcode: String
    public var format: String
    public var pageCount: Int
    public var blurbs: [Blurb]
    public var canonicalURL: URL
    public var series: ResourceRef<Series>
    public var variants: [ResourceRef<Comic>]
    public var collections: [ResourceRef<Comic>]
    public var collectedIssues: [ResourceRef<Comic>]
    public var dates: [Annotated<Date>]
    public var prices: [Annotated<Price>]
    public var thumbnail: ImageRef
    public var images: [ImageRef]
    public var creators: ResourceList<Creator>
    public var characters: ResourceList<MarvelCharacter>
    public var stories: ResourceList<Story>
    public var events: ResourceList<CosmicEvent>
}
