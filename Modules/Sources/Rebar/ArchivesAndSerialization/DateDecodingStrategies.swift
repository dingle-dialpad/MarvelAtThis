//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

extension JSONDecoder.DateDecodingStrategy {

    public static func first(using formatters: [DateFormatter]) -> Self {
        // Look into using CodableConfiguration to handle this better
        JSONDecoder.DateDecodingStrategy.custom { (decoder) throws -> Date in
            let dateContainer = try decoder.singleValueContainer()
            let dateString = try dateContainer.decode(String.self)

            if let date = formatters.compactMap({ $0.date(from:dateString) }).first {
                return date
            } else {
                let errorContext = DecodingError.Context(
                    codingPath: dateContainer.codingPath,
                    debugDescription: "Failed to decode date for dateString: \(dateString)."
                )
                throw DecodingError.dataCorrupted(errorContext)
            }
        }
    }
}
