//
//  HomeProvider.swift
//  TVSeries
//
//  Created by Danilo Henrique on 15/04/22.
//

import Foundation
import UIKit.UIImage

protocol HomeServiceProtocol {
    func fetchTVShows(completion: @escaping (Result<[TVShow], Error>) -> Void)
}

class HomeService {
    
    //MARK: - Private Constants
    
    let service = RESTService<TVMazeAPI>()
    
    //MARK: - Private Functions
    
    private func requestTVShows(completion: @escaping (Result<[TVShowResponse], Error>) -> Void) {
        service.request(.getSeries(page: 1), completion: completion)
    }
}

extension HomeService: HomeServiceProtocol {
    func fetchTVShows(completion: @escaping (Result<[TVShow], Error>) -> Void) {
        requestTVShows { result in
            switch result {
            case .success(let response):
                let TVShows = response.map({TVShow(
                    name: $0.name,
                    imageURL: $0.image.medium
                )})
                completion(.success(TVShows))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
