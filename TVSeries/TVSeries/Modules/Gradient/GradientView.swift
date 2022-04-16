//
//  GradientView.swift
//  TVSeries
//
//  Created by Danilo Henrique on 16/04/22.
//

import UIKit

class GradientView: UIView {
    init(frame: CGRect, topColor: UIColor, bottomColor: UIColor) {
        super.init(frame: frame)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = frame
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
