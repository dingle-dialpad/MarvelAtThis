//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct Annotated<Item>: Codable where Item: Codable, Item: AnnotatableItem {
    public enum CodingKeys: String, CodingKey {
        case annotation = "type"
        case url
        case date
        case price
    }

    public let annotation: String
    public let item: Item

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.annotation = try container.decode(String.self, forKey: .annotation)
        self.item = try container.decode(Item.self, forKey: Item.itemKey)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(annotation, forKey: .annotation)
        try container.encode(item, forKey: Item.itemKey)
    }
}

public protocol AnnotatableItem: Codable {
    static var itemKey: Annotated<Self>.CodingKeys { get }
}

extension URL: AnnotatableItem {
    public static let itemKey = Annotated<URL>.CodingKeys.url
}

extension Date: AnnotatableItem {
    public static let itemKey = Annotated<Date>.CodingKeys.date
}

extension Price: AnnotatableItem {
    public static let itemKey = Annotated<Price>.CodingKeys.price
}
