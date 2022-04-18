//
//  DetailViewModel.swift
//  TVSeries
//
//  Created by Danilo Henrique on 17/04/22.
//

import Foundation

import RxSwift
import UIKit.UIImage

final class DetailViewModel {
    
    enum NavigationAction {
        case showEpisodeDetail(season: Season, episode: Episode)
    }
    
    //MARK: - Private Variables
    
    private let service: DetailServiceProtocol
    private let tvShow: TVShow
    private var seasons: [Season] = []
    
    //MARK: - Private Constants
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Observables
    
    lazy var name = nameSubject.asObservable()
    private let nameSubject = BehaviorSubject<String>(value: "")

    lazy var genre = genreSubject.asObservable()
    private let genreSubject = BehaviorSubject<String>(value: "")
    
    lazy var image = imageSubject.asObservable()
    private let imageSubject = BehaviorSubject<(UIImage?)>(value: nil)
    
    lazy var aired = airedSubject.asObservable()
    private let airedSubject = BehaviorSubject<String>(value: "")
    
    lazy var navigationAction = navigationActionSubject.asObservable()
    private let navigationActionSubject = PublishSubject<NavigationAction>()
    
    lazy var summary = summarySubject.asObservable()
    private let summarySubject = BehaviorSubject<String>(value: "")
    
    lazy var seasonsObsearvable = seasonsSubject.asObservable()
    private let seasonsSubject = BehaviorSubject<[Season]>(value: [])
        
    //MARK: - Initialization
    
    init(tvShow: TVShow, service: DetailServiceProtocol) {
        self.service = service
        self.tvShow = tvShow
        nameSubject.onNext(tvShow.name)
        genreSubject.onNext(tvShow.genres.joined(separator: ", "))
        imageSubject.onNext(tvShow.image ?? UIImage(named: "movie-poster"))
        airedSubject.onNext(tvShow.scheduleDays.joined(separator: ",") + " at " + tvShow.scheduleTime)
        summarySubject.onNext(tvShow.summary.removingTags())
    }
    
    //MARK: - Public Functions
    
    func fetchSeasons() {
        service.fetchSeasons(id: tvShow.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let seasons):
                self.seasons = seasons
                self.seasonsSubject.onNext(seasons)
            case .failure(let error):
                print(#function, error)
            }
        }
    }
    
    func showEpisodeDetail(at indexPath: IndexPath) {
        navigationActionSubject.onNext(.showEpisodeDetail(
            season: seasons[indexPath.section],
            episode: seasons[indexPath.section].episodes[indexPath.row]
        ))
    }
}
