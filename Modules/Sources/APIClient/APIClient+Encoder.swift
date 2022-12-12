//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
import Rebar

extension APIClient {

    // For now encoding is purely for test snapshots, dateEncodingStrategy needs to be better managed.
    // Decoding has a fallback, encoding is always RFC3339 format
    public static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(.RFC3339)
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        return encoder
    }()

}
