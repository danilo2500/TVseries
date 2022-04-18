//
//  Extension+String.swift
//  TVSeries
//
//  Created by Danilo Henrique on 18/04/22.
//

import Foundation

extension String {
    func removingTags() -> String {
        let tags = ["<p>", "</p>", "<b>", "</b>"]
        var string = self
        tags.forEach({
            string = string.replacingOccurrences(of: $0, with: "")
        })
        return string
    }
}
