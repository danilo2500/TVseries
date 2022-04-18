//
//  HomeProvider.swift
//  TVSeries
//
//  Created by Danilo Henrique on 15/04/22.
//

import Foundation
import UIKit

protocol EpisodeDetailServiceProtocol {
    func fetchImage(withURL url: String, completion: @escaping (Result<UIImage, Error>) -> Void)
}

class EpisodeDetailService {
    
    //MARK: - Private Constants

    private let service = RESTService<TVMazeAPI>()
}

//MARK: - DetailService Protocool

extension EpisodeDetailService: EpisodeDetailServiceProtocol {
    
    func fetchImage(withURL url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        service.requestImage(urlString: url) { result in
            switch result {
            case .success(let image):
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
