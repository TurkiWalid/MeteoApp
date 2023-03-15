//
//  WrongData.swift
//  OpenWeatherMapTests
//
//  Created by Walid on 15/3/2023.
//

import Foundation
@testable import OpenWeatherMap

struct WrongDataMock: HostGateway {
    func getData(url: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        struct randomStruct: Encodable {
            let a: String
            let b: Int
        }
        let randomObject = randomStruct(a: "", b: 0)
        let encodedData = try! JSONEncoder().encode(randomObject)
        completion(.success(encodedData))
    }
    
    
}
