//
//  Succeeding.swift
//  OpenWeatherMapTests
//
//  Created by Walid on 15/3/2023.
//

import Foundation
@testable import OpenWeatherMap

struct SucceedingMock: HostGateway {
    func getData(url: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        let responseObject = OpenWeatherMapMinimalResponseModel(coord: Coord(lon: 1.0, lat: 1.0))
        let encodedData = try! JSONEncoder().encode(responseObject)
        completion(.success(encodedData))
    }
    
    
}
