//
//  HomeService.swift
//  TVSeries
//
//  Created by Danilo Henrique on 15/04/22.
//

import Foundation

enum TVMazeAPI {
    case getTVShows(page: Int)
}

extension TVMazeAPI: RESTRequest {
    
    var baseURL: String {
        return "https://api.tvmaze.com"
    }

    var path: String {
        switch self {
        case .getTVShows:
            return "/shows"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getTVShows(let page):
            return [URLQueryItem(name: "page", value: String(page))]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getTVShows:
            return .get
        }
    }
    
}
