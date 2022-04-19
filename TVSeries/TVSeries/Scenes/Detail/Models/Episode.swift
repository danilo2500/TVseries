//
//  Episode.swift
//  TVSeries
//
//  Created by Danilo Henrique on 17/04/22.
//

import Foundation
import UIKit.UIImage

class Episode {
    init(name: String, number: Int?, summary: String?, imageURL: String?) {
        self.name = name
        self.number = number
        self.summary = summary
        self.imageURL = imageURL
    }
    
    let name: String
    let number: Int?
    let summary: String?
    let imageURL: String?
}
