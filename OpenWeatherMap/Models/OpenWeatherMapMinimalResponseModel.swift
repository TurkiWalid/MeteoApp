//
//  OpenWeatherMapMinimalResponseModel.swift
//  OpenWeatherMap
//
//  Created by Walid on 12/3/2023.
//

import Foundation

// MARK: - OpenWeatherMap
struct OpenWeatherMapMinimalResponseModel: Codable {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: CurrentWeather

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current
    }
}

struct CurrentWeather: Codable {
    
    var dt         : Int?    = nil
    var sunrise    : Int?    = nil
    var sunset     : Int?    = nil
    var temp       : Double? = nil
    var feelsLike  : Double? = nil
    var pressure   : Int?    = nil
    var humidity   : Int?    = nil
    var dewPoint   : Double? = nil
    var uvi        : Double? = nil
    var clouds     : Int?    = nil
    var visibility : Int?    = nil
    var windSpeed  : Int?    = nil
    var windDeg    : Int?    = nil
    
    enum CodingKeys: String, CodingKey {
        
        case dt         = "dt"
        case sunrise    = "sunrise"
        case sunset     = "sunset"
        case temp       = "temp"
        case feelsLike  = "feels_like"
        case pressure   = "pressure"
        case humidity   = "humidity"
        case dewPoint   = "dew_point"
        case uvi        = "uvi"
        case clouds     = "clouds"
        case visibility = "visibility"
        case windSpeed  = "wind_speed"
        case windDeg    = "wind_deg"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        dt         = try values.decodeIfPresent(Int.self    , forKey: .dt         )
        sunrise    = try values.decodeIfPresent(Int.self    , forKey: .sunrise    )
        sunset     = try values.decodeIfPresent(Int.self    , forKey: .sunset     )
        temp       = try values.decodeIfPresent(Double.self , forKey: .temp       )
        feelsLike  = try values.decodeIfPresent(Double.self , forKey: .feelsLike  )
        pressure   = try values.decodeIfPresent(Int.self    , forKey: .pressure   )
        humidity   = try values.decodeIfPresent(Int.self    , forKey: .humidity   )
        dewPoint   = try values.decodeIfPresent(Double.self , forKey: .dewPoint   )
        uvi        = try values.decodeIfPresent(Double.self , forKey: .uvi        )
        clouds     = try values.decodeIfPresent(Int.self    , forKey: .clouds     )
        visibility = try values.decodeIfPresent(Int.self    , forKey: .visibility )
        windSpeed  = try values.decodeIfPresent(Int.self    , forKey: .windSpeed  )
        windDeg    = try values.decodeIfPresent(Int.self    , forKey: .windDeg    )
        
    }
    
    init(){}
    
}
