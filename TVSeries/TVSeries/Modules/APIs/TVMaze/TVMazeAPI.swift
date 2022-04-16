//
//  HomeService.swift
//  TVSeries
//
//  Created by Danilo Henrique on 15/04/22.
//

import Foundation

enum TVMazeAPI {
    case getTVShows(page: Int)
    case searchTVShow(name: String)
}

extension TVMazeAPI: RESTRequest {
    
    var baseURL: String {
        return "https://api.tvmaze.com"
    }

    var path: String {
        switch self {
        case .getTVShows:
            return "/shows"
        case .searchTVShow:
            return "/search/shows"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getTVShows(let page):
            return [URLQueryItem(name: "page", value: String(page))]
        case .searchTVShow(let name):
            return [URLQueryItem(name: "q", value: name)]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getTVShows:
            return .get
        case .searchTVShow:
            return .get
        }
    }
    
}
