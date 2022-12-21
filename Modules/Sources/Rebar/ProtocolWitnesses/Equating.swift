//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct Equating<A> {
    public let equate: (A, A) -> Bool

    public init(equate: @escaping (A, A) -> Bool) {
        self.equate = equate
    }
}

extension Equating where A: Equatable {

    public static var equatable: Self {
        Equating(equate: ==)
    }
}



