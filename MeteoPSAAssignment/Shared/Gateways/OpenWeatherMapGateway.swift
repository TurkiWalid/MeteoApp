//
//  OpenWeatherMapGateway.swift
//  MeteoPSAAssignment
//
//  Created by Walid on 12/3/2023.
//

import Foundation
import OpenWeatherMap

class OpenWeatherMapGatewayImplementation: HostGateway {
    func getData(url: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        NetworkHelper.performDataTask(urlString: url, httpMethod: "GET") { apiError, data, _ in
            if let data = data {
                completion(.success(data))
            }else {
                completion(.failure(apiError ?? .noResponse))
            }
        }
    }
}
