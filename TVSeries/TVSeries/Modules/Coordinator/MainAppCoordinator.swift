//
//  AppCoordinator.swift
//  TVSeries
//
//  Created by Danilo Henrique on 15/04/22.
//

import Foundation
import UIKit.UIViewController

final class MainAppCoordinator: Coordinator {
    
    //MARK: - Private Variables
    
    private(set) var navigationController: UINavigationController
    
    //MARK: - Initialization
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: - Public Functions
    
    func start() {
        showHomeScreen()
    }
    
    //MARK: - Private Functions
    
    private func showHomeScreen() {
        let service = HomeService()
        let viewModel = HomeViewModel(service: service)
        let viewController = HomeViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
