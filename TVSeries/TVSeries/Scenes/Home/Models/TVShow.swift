//
//  Serie.swift
//  TVSeries
//
//  Created by Danilo Henrique on 15/04/22.
//

import Foundation
import UIKit.UIImage

class TVShow {
     init(id: Int, name: String, imageURL: String?, isFavorite: Bool, genres: [String], scheduleTime: String, scheduleDays: [String], summary: String, image: UIImage? = nil) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.isFavorite = isFavorite
        self.genres = genres
        self.scheduleTime = scheduleTime
        self.scheduleDays = scheduleDays
        self.summary = summary
        self.image = image
    }
    
    let id: Int
    let name: String
    let imageURL: String?
    var isFavorite: Bool
    let genres: [String]
    let scheduleTime: String
    let scheduleDays: [String]
    let summary: String
    var image: UIImage?
}
