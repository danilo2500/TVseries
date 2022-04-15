//
//  HomeService.swift
//  TVSeries
//
//  Created by Danilo Henrique on 15/04/22.
//

import Foundation

enum TVMazeAPI {
    case getSeries
}

extension TVMazeAPI: RESTRequest {
    
    var baseURL: String {
        return ""
    }
    
    var path: String {
        switch self {
        case .getSeries:
            return ""
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getSeries:
            return nil
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getSeries:
            return .get
        }
    }
    
}
