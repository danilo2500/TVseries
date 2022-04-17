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
    private var isSearching = false
    private var searchWorkItem: DispatchWorkItem? = nil
    private var searchedTVShows: [TVShow] = []
    private var tvShows: [TVShow] = []
    
    //MARK: - Private Constants
    
    private let disposeBag = DisposeBag()
    private let service: HomeServiceProtocol
    
    //MARK: - Observables
    
    lazy var favoriteRemoved = favoriteRemovedSubject.asObservable()
    private let favoriteRemovedSubject = PublishSubject<IndexPath>()

    lazy var favoriteAdded = favoriteAddedSubject.asObservable()
    private let favoriteAddedSubject = PublishSubject<IndexPath>()
    
    lazy var images = imagesSubject.asObservable()
    private let imagesSubject = PublishSubject<(UIImage, IndexPath)>()
    
    lazy var displayedTVShows = displayedTVShowsSubject.asObservable()
    private let displayedTVShowsSubject = PublishSubject<[TVShow]>()
    
    lazy var error = errorSubject.asObservable()
    private let errorSubject = PublishSubject<String>()
        
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
    
    func addFavorite(at indexPath: IndexPath) {
        let tvShows = isSearching ? searchedTVShows : tvShows
        service.addFavorite(id: tvShows[indexPath.row].id) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print(#function, error)
                self.errorSubject.onNext("Unable to add favorite")
            } else {
                self.favoriteAddedSubject.onNext(indexPath)
            }
            
        }
    }
    
    func removeFavorite(at indexPath: IndexPath) {
        let tvShows = isSearching ? searchedTVShows : tvShows
        service.removeFavorite(id: tvShows[indexPath.row].id) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print(#function, error)
                self.errorSubject.onNext("Unable to remove from favorites")
            } else {
                self.favoriteRemovedSubject.onNext(indexPath)
            }
        }
    }
    
    func searchTVShow(name: String) {
        if name.isEmpty {
            displayedTVShowsSubject.onNext(tvShows)
            return
        }
        
        searchWorkItem?.cancel()
        
        let searchWorkItem = DispatchWorkItem { [weak self] in
            self?.service.searchTVShow(name: name) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let tvShows):
                    self.searchedTVShows.append(contentsOf: tvShows)
                    self.displayedTVShowsSubject.onNext(tvShows)
                case .failure(let error):
                    print(#function, error)
                }
            }
        }
        self.searchWorkItem = searchWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(150), execute: searchWorkItem)
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
