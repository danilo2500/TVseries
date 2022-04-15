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
    private var page = 0
    
    //MARK: - Private Constants
    
    private let disposeBag = DisposeBag()
    private let service: HomeServiceProtocol
    
    //MARK: - Observables
        
    lazy var images = imagesSubject.asObservable()
    private let imagesSubject = PublishSubject<(UIImage, IndexPath)>()
    
    lazy var tvShows = tvShowsSubject.asObservable()
    private let tvShowsSubject = BehaviorSubject<[TVShow]>(value: [])
    
    lazy var error = errorSubject.asObservable()
    private let errorSubject = PublishSubject<String>()
    
    lazy var indexPaths = errorSubject.asObservable()
        
    //MARK: - Initialization
    
    init(service: HomeServiceProtocol) {
        self.service = service
    }
    
    //MARK: - Public Functions
    
    func fetchTVShows() {
        service.fetchTVShows(page: page) { [weak self] result in
            guard let self = self else { return }
            self.page += 1
            switch result {
            case .success(let tvShows):
                self.tvShowsSubject.onNext(tvShows)
            case .failure(let error):
                print(#function, error)
                self.errorSubject.onNext("Unable to fetch Series")
            }
        }
    }
    
    func fetchImage(at indexPath: IndexPath) {
        tvShows
            .take(1)
            .map{ $0[indexPath.row] }
            .map(\.imageURL)
            .subscribe(onNext: { [weak self] imageURL in
                guard let self = self else { return }
                self.service.fetchImage(withURL: imageURL) { result in
                    switch result {
                    case .success(let image):
                        self.imagesSubject.onNext((image, indexPath))
                    case .failure(let error):
                        print(#function, error)
                    }
                }
            }).disposed(by: disposeBag)
    }
}
