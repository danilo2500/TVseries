//
//  SeriesViewModel.swift
//  TVSeries
//
//  Created by Danilo Henrique on 15/04/22.
//

import Foundation
import RxSwift
import UIKit

final class HomeViewModel {
    
    //MARK: - Private Variables
    
    ///Next page to be fetched by API
    private var page = 0
    
    //MARK: - Private Constants
    
    private let service: HomeServiceProtocol
    
    //MARK: - Observables
    
    lazy var series = seriesSubject.asObservable()
    private let seriesSubject = PublishSubject<[TVShow]>()
    
    lazy var error = errorSubject.asObservable()
    private let errorSubject = PublishSubject<String>()
    
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
            case .success(let series):
                self.seriesSubject.onNext(series)
            case .failure(let error):
                print(#function, error)
                self.errorSubject.onNext("Unable to fetch Series")
            }
        }
    }
    
}
