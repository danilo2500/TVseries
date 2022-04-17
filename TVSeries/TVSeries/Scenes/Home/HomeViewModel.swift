//
//  SeriesViewModel.swift
//  TVSeries
//
//  Created by Danilo Henrique on 15/04/22.
//

import Foundation
import RxSwift
import UIKit.UIImage

final class HomeViewModel {
    
    //MARK: - Private Variables
    
    ///Next page to be fetched by API
    private var nextPage = 0
    var isSearching = false
    private var searchedTVShows: [TVShow] = []
    private var tvShows: [TVShow] = []
    
    //MARK: - Private Constants
    
    private let disposeBag = DisposeBag()
    private let service: HomeServiceProtocol
    
    //MARK: - Observables
        
    lazy var images = imagesSubject.asObservable()
    private let imagesSubject = PublishSubject<(UIImage, IndexPath)>()
    
    lazy var displayedTVShows = displayedTVShowsSubject.asObservable()
    private let displayedTVShowsSubject = PublishSubject<[TVShow]>()
    
    lazy var error = errorSubject.asObservable()
    private let errorSubject = PublishSubject<String>()
    
    lazy var indexPaths = errorSubject.asObservable()
        
    //MARK: - Initialization
    
    init(service: HomeServiceProtocol) {
        self.service = service
    }
    
    //MARK: - Public Functions
    
    func fetchTVShows() {
        service.fetchTVShows(page: nextPage) { [weak self] result in
            guard let self = self else { return }
            self.nextPage += 1
            switch result {
            case .success(let tvShows):
                self.tvShows.append(contentsOf: tvShows)
                self.displayedTVShowsSubject.onNext(tvShows)
            case .failure(let error):
                print(#function, error)
                self.errorSubject.onNext("Unable to fetch Series")
            }
        }
    }
    
    func addFavorite(at indexPath) {
        
    }
    
    func searchTVShow(name: String) {
        if name.isEmpty {
            displayedTVShowsSubject.onNext(tvShows)
            return
        }
        service.searchTVShow(name: name) { result in
            switch result {
            case .success(let tvShows):
                self.searchedTVShows.append(contentsOf: tvShows)
                self.displayedTVShowsSubject.onNext(tvShows)
            case .failure(let error):
                print(#function, error)
            }
        }
    }
    
    func fetchImage(at indexPath: IndexPath) {
        let tvShows = isSearching ? searchedTVShows : tvShows
        guard let imageURL = tvShows[indexPath.row].imageURL else {
            imagesSubject.onNext((UIImage(), indexPath))
            return
        }
        service.fetchImage(withURL: imageURL) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                self.imagesSubject.onNext((image, indexPath))
            case .failure(let error):
                print(#function, error)
            }
        }
    }
}
