//
//  EpisodeDetailViewController.swift
//  TVSeries
//
//  Created by Danilo Henrique on 18/04/22.
//

import Foundation
import UIKit

import RxSwift

final class EpisodeDetailViewModel {
    
    //MARK: - Private Variables
    
    private let service: EpisodeDetailServiceProtocol
    
    //MARK: - Private Constants
    
    private let episode: Episode
    private let disposeBag = DisposeBag()
    
    //MARK: - Observables
    
    lazy var name = nameSubject.asObservable()
    private let nameSubject = BehaviorSubject<String>(value: "")
    
    lazy var season = seasonSubject.asObservable()
    private let seasonSubject = BehaviorSubject<String>(value: "")

    lazy var number = numberSubject.asObservable()
    private let numberSubject = BehaviorSubject<String>(value: "")
    
    lazy var image = imageSubject.asObservable()
    private let imageSubject = BehaviorSubject<(UIImage?)>(value: nil)
    
    lazy var summary = summarySubject.asObservable()
    private let summarySubject = BehaviorSubject<String>(value: "")
    
        
    //MARK: - Initialization
    
    init(episode: Episode, season: Season, service: EpisodeDetailServiceProtocol) {
        self.episode = episode
        self.service = service

        nameSubject.onNext(episode.name)
        seasonSubject.onNext(season.name)
        if let number = episode.number {
            numberSubject.onNext("Episode \(number)")
        } else {
            numberSubject.onNext("Episode number unavailable")
        }
        if let summary = episode.summary, !summary.isEmpty {
            summarySubject.onNext(summary.removingTags())
        } else {
            summarySubject.onNext("No summary available")
        }
    }
    
    //MARK: - Public Functions
    
    func fetchImage() {
        guard let imageURL = episode.imageURL else {
            let image = UIImage(named: "movie-poster") ?? UIImage()
            imageSubject.onNext(image)
            return
        }
        service.fetchImage(withURL: imageURL) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                self.imageSubject.onNext(image)
            case .failure(let error):
                print(#function, error)
                let image = UIImage(named: "movie-poster") ?? UIImage()
                self.imageSubject.onNext(image)
            }
        }
    }
}
