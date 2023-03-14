//
//  HostGateway.swift
//  OpenWeatherMap
//
//  Created by Walid on 12/3/2023.
//

import Foundation

public protocol HostGateway {
    func getData(url: String, completion: @escaping (Result<Data?, Error>) -> Void)
}
