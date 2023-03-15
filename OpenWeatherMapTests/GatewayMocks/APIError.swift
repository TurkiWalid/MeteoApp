//
//  ApiErrorStub.swift
//  OpenWeatherMapTests
//
//  Created by Walid on 15/3/2023.
//

import Foundation
@testable import OpenWeatherMap

struct ApiErrorMock: HostGateway {
    func getData(url: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        completion(.failure(FetchError.APIError))
    }
    
    
}
