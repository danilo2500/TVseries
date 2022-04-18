//
//  EpisodesResponse.swift
//  TVSeries
//
//  Created by Danilo Henrique on 17/04/22.
//

import Foundation

struct EpisodesResponse: Codable {
    let id: Int
    let url: String?
    let name: String
    let season: Int
    let number: Int?
    let type: String?
    let airdate: String?
    let airtime: String?
    let runtime: Int?
    let image: ImageResponse?
    let summary: String?
}
