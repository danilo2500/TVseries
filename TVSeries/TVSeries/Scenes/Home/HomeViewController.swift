//
//  ViewController.swift
//  TVSeries
//
//  Created by Danilo Henrique on 15/04/22.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UITableViewController {
    
    //MARK: - Private Variables
    
    private var searchWorkItem: DispatchWorkItem? = nil
    private let disposeBag = DisposeBag()
    private let viewModel: HomeViewModel
    
    //MARK: - Initialization
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        viewModel.fetchTVShows()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpGradient()
    }
    
    //MARK: - Private Functions
    
    private func setUpUI() {
        title = "TV Shows"
        setUpTableView()
        setUpSearchController()
        setUpBindings()
    }
    
    private func setUpSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.searchTextField.textColor = .white
    }
    
    private func setUpTableView() {
        tableView.dataSource = nil
        tableView.register(TVShowCell.self, forCellReuseIdentifier: String(describing: TVShowCell.self))
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .lightGray
    }
    
    private func setUpGradient() {
        tableView.backgroundView = GradientView(frame: view.bounds, topColor: .navyBlue, bottomColor: .darkRoyalBlue)
    }

    private func setUpBindings() {
        viewModel.displayedTVShows
            .bind(to: tableView.rx.items(
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
            let cell = self.tableView.cellForRow(at: indexPath) as? TVShowCell
            cell?.posterImageView.image = image
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
