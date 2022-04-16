//
//  NavigationController.swift
//  TVSeries
//
//  Created by Danilo Henrique on 16/04/22.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {
    
    //MARK: - Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Functions
    
    private func setUpUI() {
        let textAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 20, weight: .medium)
        ]

        navigationBar.tintColor = .white
        let transparentAppearance = UINavigationBarAppearance()
        transparentAppearance.configureWithTransparentBackground()
        transparentAppearance.titleTextAttributes = textAttributes
        
        let defaultAppearance = UINavigationBarAppearance()
        defaultAppearance.titleTextAttributes = textAttributes
        defaultAppearance.configureWithDefaultBackground()
        defaultAppearance.backgroundColor = .navyBlue
        defaultAppearance.shadowColor = .black
        
        navigationBar.standardAppearance = defaultAppearance
        navigationBar.compactAppearance = transparentAppearance
        navigationBar.scrollEdgeAppearance = transparentAppearance
    }
}
