//
//  Fixtures.swift
//  TVSeriesTests
//
//  Created by Danilo Henrique on 18/04/22.
//

import Foundation
@testable import TVSeries

class Fixtures {
    
    static let episode = Episode(name: String(), number: 1, summary: String(), imageURL: nil)
    static let season = Season(name: String(), number: 0, episodes: [episode])
    static let tvShow = TVShow(id: 0, name: String(), imageURL: nil, isFavorite: false, genres: [], scheduleTime: String(), scheduleDays: [], summary: String())
}
