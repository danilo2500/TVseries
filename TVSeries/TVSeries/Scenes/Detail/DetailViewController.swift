//
//  DetailViewController.swift
//  TVSeries
//
//  Created by Danilo Henrique on 17/04/22.
//

import Foundation
import RxSwift
import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Private Properties
    
    private let disposeBag = DisposeBag()
    private let viewModel: DetailViewModel
    private let ui = DetailView()
    
    //MARK: - Initialization
    
    init(viewModel: DetailViewModel) {
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
    }
    
    //MARK: - Private Functions
    
    private func setUpBindings() {
        viewModel.name.bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        viewModel.image.bind(to: ui.imageView.rx.image).disposed(by: disposeBag)
        viewModel.aired.bind(to: ui.airedDateLabel.rx.text).disposed(by: disposeBag)
        viewModel.genre.bind(to: ui.genresLabel.rx.text).disposed(by: disposeBag)
        viewModel.summary.bind(to: ui.summaryLabel.rx.text).disposed(by: disposeBag)
    }
}
