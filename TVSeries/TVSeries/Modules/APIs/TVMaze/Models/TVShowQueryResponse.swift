//
//  TVShowQueryResponse.swift
//  TVSeries
//
//  Created by Danilo Henrique on 15/04/22.
//

import Foundation

struct TVShowQueryResponse: Codable {
    let score: Double
    let show: TVShowResponse
}
