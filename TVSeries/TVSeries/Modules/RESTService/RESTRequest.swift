//
//  RequestProtocol.swift
//  TVSeries
//
//  Created by Danilo Henrique on 15/04/22.
//

import Foundation

protocol RESTRequest {
    var baseURL: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var httpMethod: HTTPMethod { get }
}
