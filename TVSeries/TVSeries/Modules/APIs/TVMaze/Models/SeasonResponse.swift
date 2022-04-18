//
//  SeasonResponse.swift
//  TVSeries
//
//  Created by Danilo Henrique on 18/04/22.
//

import Foundation

struct SeasonResponse: Codable {
    let id: Int
    let url: String?
    let name: String
    let season: Int?
    let number: Int
    let airdate: String?
    let airtime: String?
    let runtime: Int?
    let image: ImageResponse?
    let summary: String?
}
