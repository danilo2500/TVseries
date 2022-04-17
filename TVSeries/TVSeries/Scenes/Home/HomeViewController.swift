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
    
    private var tvShows: [TVShow] = []
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
    
    //MARK: - Private Functions
    
    private func setUpUI() {
        view.backgroundColor = .black
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
        tableView.register(TVShowCell.self, forCellReuseIdentifier: String(describing: TVShowCell.self))
        tableView.separatorColor = .lightGray
        tableView.estimatedRowHeight = 194
    }
    
    private func setUpBindings() {
        viewModel.displayedTVShows.subscribe(onNext: { [weak self] tvShows in
            guard let self = self else { return }
            self.tvShows = tvShows
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
                  
        viewModel.images.subscribe { [weak self] image, indexPath in
            guard let self = self else { return }
            let cell = self.tableView.cellForRow(at: indexPath) as? TVShowCell
            cell?.activiyIndicator.stopAnimating()
            cell?.posterImageView.image = image
        }.disposed(by: disposeBag)
        
        viewModel.favoriteAdded.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else { return }
            self.tvShows[indexPath.row].isFavorite = true
            let cell = self.tableView.cellForRow(at: indexPath) as? TVShowCell
            cell?.showFavorite(animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.favoriteRemoved.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else { return }
            self.tvShows[indexPath.row].isFavorite = false
            let cell = self.tableView.cellForRow(at: indexPath) as? TVShowCell
            cell?.removeFavorite(animated: true)
        }).disposed(by: disposeBag)
    }
}

//MARK: - UITableView Delegate/Data Source

extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TVShowCell.self), for: indexPath) as? TVShowCell
                
        let tvShow = tvShows[indexPath.row]
        cell?.nameLabel.text = tvShow.name
        if tvShow.isFavorite {
            cell?.showFavorite(animated: false)
        }
        viewModel.fetchImage(at: indexPath)
                
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showDetail(at: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let isFavorite = tvShows[indexPath.row].isFavorite
        
        let action = UIContextualAction(
            style: .normal,
            title: isFavorite ? "Remove Favorite" : "Add Favorite"
        ) { [weak self] _, _, completion in
            if isFavorite {
                self?.viewModel.removeFavorite(at: indexPath)
            } else {
                self?.viewModel.addFavorite(at: indexPath)
            }
            completion(true)
        }
        action.image = isFavorite ? UIImage(named: "empty-star") : UIImage(named: "filled-star") 
        action.backgroundColor = .black

        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {            viewModel.searchTVShow(name: searchController.searchBar.text ?? "")
    }
    
}
