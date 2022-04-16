//
//  SerieResposne.swift
//  TVSeries
//
//  Created by Danilo Henrique on 15/04/22.
//

import Foundation

struct TVShowResponse: Codable {
    let id: Int?
    let url: String?
    let name: String
    let type: String?
    let language: String?
    let genres: [String]?
    let status: String?
    let runtime: Int?
    let averageRuntime: Int?
    let premiered, ended: String?
    let officialSite: String?
    let schedule: ScheduleResponse?
    let rating: RatingResponse?
    let weight: Int?
    let network: NetworkResponse?
    let webChannel: NetworkResponse?
    let externals: ExternalsResponse?
    let image: ImageResponse?
    let summary: String?
    let updated: Int?
    let links: LinksResponse?

    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, averageRuntime, premiered, ended, officialSite, schedule, rating, weight, network, webChannel, externals, image, summary, updated
        case links = "_links"
    }
}

// MARK: - Externals
struct ExternalsResponse: Codable {
    let tvrage: Int?
    let thetvdb: Int?
    let imdb: String?
}

// MARK: - Image
struct ImageResponse: Codable {
    let medium: String
    let original: String
}

// MARK: - Links
struct LinksResponse: Codable {
    let linksSelf: NextEpisodeResponse
    let previousepisode: NextEpisodeResponse?
    let nextepisode: NextEpisodeResponse?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case previousepisode, nextepisode
    }
}

// MARK: - Next Episode
struct NextEpisodeResponse: Codable {
    let href: String
}

// MARK: - Network
struct NetworkResponse: Codable {
    let id: Int
    let name: String
    let country: CountryResponse?
    let officialSite: String?
}

// MARK: - Country
struct CountryResponse: Codable {
    let name: String
    let code: String
    let timezone: String
}

// MARK: - Rating
struct RatingResponse: Codable {
    let average: Double?
}

// MARK: - Schedule
struct ScheduleResponse: Codable {
    let time: String
    let days: [String]
}
