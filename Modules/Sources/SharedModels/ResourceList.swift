//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct ResourceList<A> {
    public var total: Int
    public var items: [ResourceRef<A>]
}

public struct ResourceRef<A> {
    public var uri: String
    public var name: String
}
