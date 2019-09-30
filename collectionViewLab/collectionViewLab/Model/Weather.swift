//
//  Weather.swift
//  collectionViewLab
//
//  Created by God on 9/30/19.
//  Copyright © 2019 God. All rights reserved.
//
import Foundation

// MARK: - Weather
struct Weather: Codable {
    let consolidatedWeather: [ConsolidatedWeather]
    let time, sunRise, sunSet, timezoneName: String
    let parent: Parent
    let sources: [Source]
    let title, locationType: String
    let woeid: Int
    let lattLong, timezone: String
    
    
    static func decodeWeather(from jsonData: Data) throws -> [Weather] {
        let response = try JSONDecoder().decode([Weather].self, from: jsonData)
        return response
    }
    
    enum CodingKeys: String, CodingKey {
        case consolidatedWeather
        case time
        case sunRise
        case sunSet
        case timezoneName
        case parent, sources, title
        case locationType
        case woeid
        case lattLong
        case timezone
    }
}

// MARK: - ConsolidatedWeather
struct ConsolidatedWeather: Codable {
    let id: Int
    let weatherStateName, weatherStateAbbr, windDirectionCompass, created: String
    let applicableDate: String
    let minTemp, maxTemp, theTemp, windSpeed: Double
    let windDirection, airPressure: Double
    let humidity: Int
    let visibility: Double
    let predictability: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case weatherStateName
        case weatherStateAbbr
        case windDirectionCompass
        case created
        case applicableDate
        case minTemp
        case maxTemp
        case theTemp
        case windSpeed
        case windDirection
        case airPressure
        case humidity, visibility, predictability
    }
}

// MARK: - Parent
struct Parent: Codable {
    let title, locationType: String
    let woeid: Int
    let lattLong: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case locationType
        case woeid
        case lattLong
    }
}

// MARK: - Source
struct Source: Codable {
    let title, slug: String
    let url: String
    let crawlRate: Int
    
    enum CodingKeys: String, CodingKey {
        case title, slug, url
        case crawlRate
    }
}
