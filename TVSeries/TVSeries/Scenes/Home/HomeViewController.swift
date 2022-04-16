//
//  ViewController.swift
//  TVSeries
//
//  Created by Danilo Henrique on 15/04/22.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UICollectionViewController {
    
    //MARK: - Private Variables
    
    private var searchWorkItem: DispatchWorkItem? = nil
    private let disposeBag = DisposeBag()
    private let viewModel: HomeViewModel
    
    //MARK: - Initialization
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let flowLayout = UICollectionViewCompositionalLayout.list(using: configuration)
        super.init(collectionViewLayout: flowLayout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TV Shows"
        setUpBindings()
        setUpSearchController()
        viewModel.fetchTVShows()
    }
    
    //MARK: - Private Functions
    
    private func setUpSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func setUpBindings() {
        collectionView.dataSource = nil
        collectionView.register(TVShowCell.self, forCellWithReuseIdentifier: String(describing: TVShowCell.self))
        viewModel.displayedTVShows
            .bind(to: collectionView.rx.items(
                cellIdentifier: String(describing: TVShowCell.self),
                cellType: TVShowCell.self
            )) { row, tvShow, cell in
                cell.nameLabel.text = tvShow.name
                self.viewModel.fetchImage(at: IndexPath(row: row, section: 0))
        }.disposed(by: disposeBag)
        
//        tableView.rx.prefetchRows.subscribe(onNext: { [weak self] indexPaths in
//            indexPaths.forEach({
//                self?.viewModel.fetchImage(at: $0)
//            })
//        }).disposed(by: disposeBag)
        
        viewModel.images.subscribe { [weak self] image, indexPath in
            guard let self = self else { return }
            let cell = self.collectionView.cellForItem(at: indexPath) as? TVShowCell
            cell?.imageView.image = image
        }.disposed(by: disposeBag)
    }

    
}


extension HomeViewController: UISearchResultsUpdating {
        
    func updateSearchResults(for searchController: UISearchController) {
        searchWorkItem?.cancel()
        
        let searchWorkItem = DispatchWorkItem { [weak self] in
            self?.viewModel.searchTVShow(name: searchController.searchBar.text ?? "")
        }
        self.searchWorkItem = searchWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(150), execute: searchWorkItem)
    }
    
}
