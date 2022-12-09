//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct Creator: Codable {
    public let id: Int
    public var firstName: String
    public var middleName: String
    public var lastName: String
    public var suffix: String
    public var fullName: String
    public var lastModified: Date
    public var cannonicalURL: URL
    public var urls: [Annotated<URL>]
    public var thumbnail: ImageRef
    public var series: ResourceList<Series>
    public var stories: ResourceList<Story>
    public var comics: ResourceList<Comic>
    public var events: ResourceList<CosmicEvent>
}
