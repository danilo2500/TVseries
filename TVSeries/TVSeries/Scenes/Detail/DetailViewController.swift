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
    private var seasons: [Season] = []
    private let loadingView = LoadingView()
    
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
        setUpTableView()
        setUpBindings()
        viewModel.fetchSeasons()
    }
    
    //MARK: - Private Functions
    
    private func setUpBindings() {
        viewModel.name.bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        viewModel.image.bind(to: ui.imageView.rx.image).disposed(by: disposeBag)
        viewModel.aired.bind(to: ui.airedDateLabel.rx.text).disposed(by: disposeBag)
        viewModel.genre.bind(to: ui.genresLabel.rx.text).disposed(by: disposeBag)
        viewModel.summary.bind(to: ui.summaryLabel.rx.text).disposed(by: disposeBag)
        viewModel.seasonsObsearvable.bind { [weak self] seasons in
            guard let self = self else { return }
            self.seasons = seasons
            self.ui.seasonsTableView.reloadData()
        }.disposed(by: disposeBag)
        viewModel.isLoading.subscribe(onNext: { [weak self] isLoading in
            guard let self = self else { return }
            if isLoading {
                self.loadingView.showOnView(self.view)
            } else {
                self.loadingView.dismiss()
            }
        }).disposed(by: disposeBag)
    }
    
    private func setUpTableView() {
        ui.seasonsTableView.delegate = self
        ui.seasonsTableView.dataSource = self
        ui.seasonsTableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return seasons.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasons[section].episodes.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return seasons[section].name
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.textColor = .white
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        
        let episode = seasons[indexPath.section].episodes[indexPath.row]
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = episode.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showEpisodeDetail(at: indexPath)
    }
}
