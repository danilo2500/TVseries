//
//  AppCoordinator.swift
//  TVSeries
//
//  Created by Danilo Henrique on 15/04/22.
//

import Foundation
import UIKit.UIViewController
import RxSwift

final class MainAppCoordinator: Coordinator {
    
    //MARK: - Private Variables
    
    private(set) var navigationController: UINavigationController
    private let disposeBag = DisposeBag()
    
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
        
        viewModel.navigationAction.subscribe(onNext: { [weak self] navigationAction in
            guard let self = self else { return }
            switch navigationAction {
            case .showDetail(let tvShow):
                self.showDetailScreen(tvShow: tvShow)
            }
        }).disposed(by: disposeBag)
    }
    
    private func showDetailScreen(tvShow: TVShow) {
        let service = DetailService()
        let viewModel = DetailViewModel(tvShow: tvShow, service: service)
        let viewController = DetailViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
