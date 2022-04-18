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
    case episodes(seasonID: String)
    case seasons(showID: String)
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
        case .episodes(let seasonID):
            return "/seasons/\(seasonID)/episodes"
        case .seasons(showID: let showID):
            return "/shows/\(showID)/seasons"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getTVShows(let page):
            return [URLQueryItem(name: "page", value: String(page))]
        case .searchTVShow(let name):
            return [URLQueryItem(name: "q", value: name)]
        case .episodes:
            return nil
        case .seasons:
            return nil
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getTVShows:
            return .get
        case .searchTVShow:
            return .get
        case .episodes:
            return .get
        case .seasons:
            return .get
        }
    }
    
}
