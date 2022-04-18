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
    func addFavorite(id: Int, completion: @escaping (Error?) -> Void)
    func removeFavorite(id: Int, completion: @escaping (Error?) -> Void)
}

class HomeService {
    
    //MARK: - Private Variables
    
    private var cachedImages: [String: UIImage] = [:]
    
    //MARK: - Private Constants
    
    private let coreDataManager = CoreDataManager()
    private let service = RESTService<TVMazeAPI>()
    
    //MARK: - Private Functions
    
    private func requestTVShows(page: Int, completion: @escaping (Result<[TVShowResponse], Error>) -> Void) {
        service.request(.getTVShows(page: page), completion: completion)
    }
    
    private func requestSearchTVShows(name: String, completion: @escaping (Result<[TVShowQueryResponse], Error>) -> Void) {
        service.request(.searchTVShow(name: name), completion: completion)
    }
    
    private func requestFavoritesID(completion: @escaping (Result<[Int], Error>) -> Void) {
        CoreDataManager().getAll(entityType: TVShowEntity.self) { result in
            switch result {
            case .success(let tvShowEntities):
                let ids = tvShowEntities.map({ Int($0.id) })
                completion(.success(ids))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func createTVShow(from response: [TVShowResponse], favoriteIDs: [Int]) -> [TVShow] {
        return response.map { response in
            return TVShow(
                id: response.id,
                name: response.name,
                imageURL:  response.image?.medium,
                isFavorite: favoriteIDs.contains(where: {response.id == $0}),
                genres: response.genres,
                scheduleTime: response.schedule.time,
                scheduleDays: response.schedule.days,
                summary: response.summary
            )
        }
    }
}

//MARK: - HomeServiceProtocol

extension HomeService: HomeServiceProtocol {
    
    //MARK: - Core data
    
    func addFavorite(id: Int, completion: @escaping (Error?) -> Void) {
        let object = TVShowEntity()
        object.id = Int32(id)
        
        CoreDataManager().save(object: object, completion: completion)
    }
    
    func removeFavorite(id: Int, completion: (Error?) -> Void) {
        CoreDataManager().get(entityType: TVShowEntity.self, withId: id) { (result) in
            switch result {
            case .success(let favorites):
                favorites.forEach { CoreDataManager().delete(object: $0, completion: nil)}
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    //MARK: - Service
    
    func searchTVShow(name: String, completion: @escaping (Result<[TVShow], Error>) -> Void) {
        var favoriteIDs: [Int] = []
        requestFavoritesID { result in
            if case let .success(ids) = result {
                favoriteIDs = ids
            }
        }
        requestSearchTVShows(name: name) { result in
            switch result {
            case .success(let response):
                let shows = response.map(\.show)
                let TVShows = self.createTVShow(from: shows, favoriteIDs: favoriteIDs)
                completion(.success(TVShows))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTVShows(page: Int, completion: @escaping (Result<[TVShow], Error>) -> Void) {
        var favoriteIDs: [Int] = []
        requestFavoritesID { result in
            if case let .success(ids) = result {
                favoriteIDs = ids
            }
        }
        requestTVShows(page: page) { result in
            switch result {
            case .success(let response):
                let TVShows = self.createTVShow(from: response, favoriteIDs: favoriteIDs)
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
