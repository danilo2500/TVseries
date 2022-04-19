//
//  Episode.swift
//  TVSeries
//
//  Created by Danilo Henrique on 17/04/22.
//

import Foundation

class Season {
    init(name: String, number: Int, episodes: [Episode]) {
        self.name = name
        self.number = number
        self.episodes = episodes
    }
    
    let name: String
    let number: Int
    var episodes: [Episode]
}
