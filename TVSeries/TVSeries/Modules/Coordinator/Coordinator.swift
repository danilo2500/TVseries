//
//  Coordinator.swift
//  TVSeries
//
//  Created by Danilo Henrique on 15/04/22.
//

import Foundation
import UIKit.UIViewController

protocol Coordinator {
    var navigationController: UINavigationController { get }
    func start()
}
