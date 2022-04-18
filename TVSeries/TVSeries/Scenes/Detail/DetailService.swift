//
//  HomeProvider.swift
//  TVSeries
//
//  Created by Danilo Henrique on 15/04/22.
//

import Foundation
import UIKit

protocol DetailServiceProtocol {
    func fetchSeasons(id: Int, completion: @escaping (Result<[Season], Error>) -> Void)
}

class DetailService {
    
    //MARK: - Private Constants

    private let service = RESTService<TVMazeAPI>()
    
    //MARK: - Private Functions
    
    private func requestSeasons(showID: Int, completion: @escaping (Result<[SeasonResponse], Error>) -> Void) {
        service.request(.seasons(showID: String(showID)), completion: completion)
    }
    
    private func requestEpisodes(seasonID: Int, completion: @escaping (Result<[EpisodesResponse], Error>) -> Void) {
        service.request(.episodes(seasonID: String(seasonID)), completion: completion)
    }
    
    private func handleSeasonsResponse(_ response: [SeasonResponse], completion: @escaping (Result<[Season], Error>) -> Void) {
        let dispatchGroup = DispatchGroup()
        var seasons: [Season] = []
        
        response.forEach { season in
            dispatchGroup.enter()
            requestEpisodes(seasonID: season.id) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    let episodes = self.createEpisodes(fromReponse: response)
                    let season = self.createSeason(seasonResponse: season, episodes: episodes)
                    seasons.append(season)
                    dispatchGroup.leave()
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            seasons.sort(by: {$0.number < $1.number})
            completion(.success(seasons))
        }
    }
    
    private func createEpisodes(fromReponse response: [EpisodesResponse]) -> [Episode] {
        return response.map {
            return Episode(
                name: $0.name,
                number: $0.number,
                summary: $0.summary,
                imageURL: $0.image?.medium,
                image: nil
            )
        }
    }
    
    private func createSeason(seasonResponse: SeasonResponse, episodes: [Episode]) -> Season {
        return Season(
            name: seasonResponse.name.isEmpty ? "Season \(seasonResponse.number)" : seasonResponse.name,
            number: seasonResponse.number,
            episodes: episodes
        )
    }
}

//MARK: - DetailService Protocool

extension DetailService: DetailServiceProtocol {
    
    func fetchSeasons(id: Int, completion: @escaping (Result<[Season], Error>) -> Void) {
        requestSeasons(showID: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.handleSeasonsResponse(response, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
