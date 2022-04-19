//
//  EpisodeDetailViewController.swift
//  TVSeries
//
//  Created by Danilo Henrique on 18/04/22.
//

import Foundation
import RxSwift
import UIKit

class EpisodeDetailViewController: UIViewController {
    
    //MARK: - Private Properties
    
    private let disposeBag = DisposeBag()
    private let viewModel: EpisodeDetailViewModel
    private let ui = EpisodeDetailView()
    private let loadingView = LoadingView()
    
    //MARK: - Initialization
    
    init(viewModel: EpisodeDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    
    override func loadView() {
        view = ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
        viewModel.fetchImage()
        
    }
    
    //MARK: - Private Functions
    
    private func setUpBindings() {
        viewModel.name.bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        viewModel.image.bind(to: ui.imageView.rx.image).disposed(by: disposeBag)
        viewModel.number.bind(to: ui.numberLabel.rx.text).disposed(by: disposeBag)
        viewModel.season.bind(to: ui.seasonLabel.rx.text).disposed(by: disposeBag)
        viewModel.summary.bind(to: ui.summaryLabel.rx.text).disposed(by: disposeBag)
        viewModel.isLoading.subscribe(onNext: { [weak self] isLoading in
            guard let self = self else { return }
            if isLoading {
                self.loadingView.showOnView(self.view)
            } else {
                self.loadingView.dismiss()
            }
        }).disposed(by: disposeBag)
    }
}
