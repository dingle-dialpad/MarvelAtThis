//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct APIError: Error, Decodable {
    public let code: Int
    public let status: String?
}
