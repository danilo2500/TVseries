//
//  TVSeriesTests.swift
//  TVSeriesTests
//
//  Created by Danilo Henrique on 15/04/22.
//

import XCTest
@testable import TVSeries

class DetailViewModelTests: XCTestCase {

    private var viewModel: DetailViewModel!
    private var service: DetailServiceSpy!

    
    override func setUp() {
        super.setUp()
        service = to DetailServiceSpy()
        viewModel = DetailViewModel(tvShow: Fixtures.tvShow, service: service)
    }
    
    override func tearDown() {
        super.tearDown()
        service = nil
        viewModel = nil
    }
    
    func testFetchSeasonsIsCallingService() {
        viewModel.fetchSeasons()
        
        XCTAssertTrue(service.fetchSeasonsCalled)
    }

}
