//
//  NSErrors.swift
//  TVSeries
//
//  Created by Danilo Henrique on 15/04/22.
//

import Foundation

public enum RESTError: Error {
    ///Could not create valid URL
    case failedToCreateURL
}


// MARK: - Error Descriptions

extension RESTError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedToCreateURL:
            return "Failed to create URL"
        }
    }
}
