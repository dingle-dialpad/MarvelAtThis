//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct APIResponse {
    public let data: Data
    public let metadata: URLResponse

    public init(data: Data, metadata: URLResponse) {
        self.data = data
        self.metadata = metadata
    }
}
