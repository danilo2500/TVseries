//
//  ViewController.swift
//  TVSeries
//
//  Created by Danilo Henrique on 15/04/22.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UITableViewController {
    
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
        view.backgroundColor = .white
        setUpBindings()
        viewModel.fetchSeries()
    }

    private func setUpBindings() {
        tableView.dataSource = nil
        viewModel.series.bind(to: tableView.rx.items) { tableView, indexPath, serie in
            let cell = UITableViewCell(style: .default, reuseIdentifier: "")
            cell.textLabel?.text = serie.name
            return cell
        }.disposed(by: disposeBag)
    }
}

