//
//  OptimalRequest.swift
//  OpenWeatherMapTests
//
//  Created by Walid on 15/3/2023.
//

import Foundation
@testable import OpenWeatherMap

struct FetchRequestRequestMocks {
    static var optimaRequest: OpenWeatherMapRequestModel {
        return OpenWeatherMapRequestModel(lat: 1.0, lon: 1.0,units: .Metric, lang: "fr")
    }
    static var minimalRequest: OpenWeatherMapRequestModel {
        return OpenWeatherMapRequestModel(lat: 1.0, lon: 1.0)
    }
}
