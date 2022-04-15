//
//  SeriesViewModel.swift
//  TVSeries
//
//  Created by Danilo Henrique on 15/04/22.
//

import Foundation
import RxSwift
import UIKit

class HomeViewModel {
    
    //MARK: - Observables
    
    lazy var series = seriesSubject.asObservable()
    private let seriesSubject = PublishSubject<[Serie]>()
    
    func fetchSeries() {
        let series: [Serie] = [
            .init(name: "Example", image: UIImage())
        ]
        seriesSubject.onNext(series)
    }
}
