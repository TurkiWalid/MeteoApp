//
//  OpenWeatherMapRequestModel.swift
//  OpenWeatherMap
//
//  Created by Walid on 12/3/2023.
//

import Foundation


public enum MetricsUnit: String {
    case Standard = "standard"
    case Metric = "metric"
    case Imperial = "imperial"
}

public struct OpenWeatherMapRequestModel {
    
    let lat: Double
    let lon: Double
    public var units: MetricsUnit
    public var lang: String?
    
    public init(lat: Double, lon: Double, units: MetricsUnit? = nil, lang: String? = nil) {
        self.lat = lat
        self.lon = lon
        self.units = units ?? .Standard
        self.lang = lang
    }
    
    var parametersEncoded: String {
        var content = "&lat=\(lat)&lon=\(lon)&exclude=minutely,hourly,daily,alerts&units=\(units.rawValue)"
        if let lang = lang {
            content += "&lang=\(lang)"
        }
        return content
    }
}
