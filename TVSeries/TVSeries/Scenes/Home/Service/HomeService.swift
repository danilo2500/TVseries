//
//  HomeProvider.swift
//  TVSeries
//
//  Created by Danilo Henrique on 15/04/22.
//

import Foundation
import UIKit.UIImage

protocol HomeServiceProtocol {
    func fetchTVShows(page: Int, completion: @escaping (Result<[TVShow], Error>) -> Void)
    func searchTVShow(name: String, completion: @escaping (Result<[TVShow], Error>) -> Void)
    func fetchImage(withURL url: String, completion: @escaping (Result<UIImage, Error>) -> Void)
}

class HomeService {
    
    //MARK: - Private Variables
    
    private var cachedTVShows: [Int: [TVShow]] = [:]
    private var cachedImages: [String: UIImage] = [:]
    
    //MARK: - Private Constants
    
    let service = RESTService<TVMazeAPI>()
    
    //MARK: - Private Functions
    
    private func requestTVShows(page: Int, completion: @escaping (Result<[TVShowResponse], Error>) -> Void) {
        service.request(.getTVShows(page: page), completion: completion)
    }
    
    private func requestSearchTVShows(name: String, completion: @escaping (Result<[TVShowQueryResponse], Error>) -> Void) {
        service.request(.searchTVShow(name: name), completion: completion)
    }
}

//MARK: - HomeServiceProtocol

extension HomeService: HomeServiceProtocol {
    func searchTVShow(name: String, completion: @escaping (Result<[TVShow], Error>) -> Void) {
        requestSearchTVShows(name: name) { result in
            switch result {
            case .success(let response):
                let TVShows = response.map(\.show).map({TVShow(response: $0)})
                completion(.success(TVShows))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTVShows(page: Int, completion: @escaping (Result<[TVShow], Error>) -> Void) {
        if let cachedTVShows = cachedTVShows[page] {
            completion(.success(cachedTVShows))
        }

        requestTVShows(page: page) { result in
            switch result {
            case .success(let response):
                let TVShows = response.map({TVShow(response: $0)})
                completion(.success(TVShows))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchImage(withURL url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let image = cachedImages[url] {
            DispatchQueue.main.async {
                completion(.success(image))
            }
        } else {
            service.requestImage(urlString: url) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let image):
                    self.cachedImages[url] = image
                    completion(.success(image))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

extension TVShow {
    init(response: TVShowResponse) {
        name = response.name ?? "-"
        imageURL = response.image?.medium
    }
}
