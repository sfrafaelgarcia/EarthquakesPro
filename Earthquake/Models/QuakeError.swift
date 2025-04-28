//
//  QuakeError.swift
//  Earthquake
//
//  Created by Rafael Garcia on 4/27/25.
//

import Foundation

enum QuakeError: Error {
    case missingData

}

extension QuakeError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString(
                "Found and will discard a queake missing a valid code, magnitude, place, or time", comment: "")
        }
    }
}
