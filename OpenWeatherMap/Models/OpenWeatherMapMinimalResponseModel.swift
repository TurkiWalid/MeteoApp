//
//  OpenWeatherMapMinimalResponseModel.swift
//  OpenWeatherMap
//
//  Created by Walid on 12/3/2023.
//

import Foundation

// MARK: - OpenWeatherMap
public struct OpenWeatherMapMinimalResponseModel: Codable {
    public var coord: Coord
    public var weather: [Weather]?
    public var base: String?
    public var main: Main?
    public var visibility: Int?
    public var wind: Wind?
    public var rain: Rain?
    public var clouds: Clouds?
    public var dt: Int?
    public var sys: Sys?
    public var timezone, id: Int?
    public var name: String?
    public var cod: Int?
}

// MARK: - Clouds
public struct Clouds: Codable {
    public var all: Int?
}

// MARK: - Coord
public struct Coord: Codable {
    public var lon, lat: Double
}

// MARK: - Main
public struct Main: Codable {
    public var temp, feelsLike, tempMin, tempMax: Double?
    public var pressure, humidity, seaLevel, grndLevel: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Rain
public struct Rain: Codable {
    public var the1H: Double?

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

// MARK: - Sys
public struct Sys: Codable {
    public var type, id: Int?
    public var country: String?
    public var sunrise, sunset: Int?
}

// MARK: - Weather
public struct Weather: Codable {
    public var id: Int?
    public var main, description, icon: String?
}

// MARK: - Wind
public struct Wind: Codable {
    public var speed: Double?
    public var deg: Int?
    public var gust: Double?
}
