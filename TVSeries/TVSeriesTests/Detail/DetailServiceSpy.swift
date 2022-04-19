//
//  EmptyDetailService.swift
//  TVSeriesTests
//
//  Created by Danilo Henrique on 18/04/22.
//

import Foundation
@testable import TVSeries

class DetailServiceSpy: DetailServiceProtocol {
    
    var fetchSeasonsCalled = false
    
    var shouldSuccessFetchSeasons = true
    
    func fetchSeasons(id: Int, completion: @escaping (Result<[Season], Error>) -> Void) {
        fetchSeasonsCalled = true
        if shouldSuccessFetchSeasons {
            completion(.success([Fixtures.season]))
        } else {
            completion(.failure(NSError()))
        }
        
    }
}
