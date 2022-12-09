//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct APIResponse {
    public let data: Data
    public let metadata: HTTPURLResponse?

    public init(data: Data, metadata: HTTPURLResponse?) {
        self.data = data
        self.metadata = metadata
    }
}
