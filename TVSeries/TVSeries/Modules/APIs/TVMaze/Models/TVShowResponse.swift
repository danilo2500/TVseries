//
//  SerieResposne.swift
//  TVSeries
//
//  Created by Danilo Henrique on 15/04/22.
//

import Foundation

struct TVShowResponse: Codable {
    let id: Int
    let url: String
    let name: String
    let type: TVShowTypeResponse
    let language: LanguageResponse
    let genres: [String]
    let status: StatusResponse
    let runtime: Int?
    let averageRuntime: Int?
    let premiered, ended: String?
    let officialSite: String?
    let schedule: ScheduleResponse
    let rating: RatingResponse
    let weight: Int
    let network: NetworkResponse?
    let webChannel: NetworkResponse?
    let externals: ExternalsResponse
    let image: ImageResponse
    let summary: String
    let updated: Int
    let links: LinksResponse

    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, averageRuntime, premiered, ended, officialSite, schedule, rating, weight, network, webChannel, externals, image, summary, updated
        case links = "_links"
    }
}

// MARK: - Externals
struct ExternalsResponse: Codable {
    let tvrage: Int
    let thetvdb: Int?
    let imdb: String?
}

// MARK: - Image
struct ImageResponse: Codable {
    let medium: String
    let original: String
}

enum LanguageResponse: String, Codable {
    case english = "English"
    case japanese = "Japanese"
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

// MARK: - Nextepisode
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
    let name: CountryNameResponse
    let code: CountryCodeResponse
    let timezone: TimeZoneResponse
}

enum CountryCodeResponse: String, Codable {
    case ca = "CA"
    case fr = "FR"
    case gb = "GB"
    case jp = "JP"
    case us = "US"
}

enum CountryNameResponse: String, Codable {
    case canada = "Canada"
    case france = "France"
    case japan = "Japan"
    case unitedKingdom = "United Kingdom"
    case unitedStates = "United States"
}

enum TimeZoneResponse: String, Codable {
    case americaHalifax = "America/Halifax"
    case americaNewYork = "America/New_York"
    case asiaTokyo = "Asia/Tokyo"
    case europeLondon = "Europe/London"
    case europeParis = "Europe/Paris"
}

// MARK: - Rating
struct RatingResponse: Codable {
    let average: Double?
}

// MARK: - Schedule
struct ScheduleResponse: Codable {
    let time: String
    let days: [DayResponse]
}

enum DayResponse: String, Codable {
    case friday = "Friday"
    case monday = "Monday"
    case saturday = "Saturday"
    case sunday = "Sunday"
    case thursday = "Thursday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
}

enum StatusResponse: String, Codable {
    case ended = "Ended"
    case running = "Running"
    case toBeDetermined = "To Be Determined"
}

enum TVShowTypeResponse: String, Codable {
    case animation = "Animation"
    case documentary = "Documentary"
    case news = "News"
    case panelShow = "Panel Show"
    case reality = "Reality"
    case scripted = "Scripted"
    case sports = "Sports"
    case talkShow = "Talk Show"
    case variety = "Variety"
}
