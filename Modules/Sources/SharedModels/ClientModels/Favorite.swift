//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct Favorite<A>: Identifiable, Codable where A: Identifiable, A.ID: Codable {
    public let id: A.ID

    public init(value: A) {
        self.id = value.id
    }
}
