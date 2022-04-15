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
    
    let disposeBag = DisposeBag()
    let viewModel: HomeViewModel
    
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
//        view.backgroundColor = .white
        setUpBindings()
        viewModel.fetchTVShows()
    }

    private func setUpBindings() {
        tableView.dataSource = nil
        viewModel.tvShows.bind(to: tableView.rx.items) { tableView, row, tvShow in
            let cell = UITableViewCell(style: .default, reuseIdentifier: "")
            cell.textLabel?.text = tvShow.name
            self.viewModel.fetchImage(at: IndexPath(row: row, section: 0))
            cell.imageView?.image = UIImage()
            return cell
        }.disposed(by: disposeBag)
        
        tableView.rx.prefetchRows.subscribe(onNext: { [weak self] indexPaths in
            indexPaths.forEach({
                self?.viewModel.fetchImage(at: $0)
            })
        }).disposed(by: disposeBag)
        
        viewModel.images.subscribe { [weak self] image, indexPath in
            guard let self = self else { return }
            let cell = self.tableView.cellForRow(at: indexPath)
            cell?.imageView?.image = image
        }.disposed(by: disposeBag)

    }

}

