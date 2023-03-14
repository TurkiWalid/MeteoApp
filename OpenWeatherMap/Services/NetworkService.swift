//
//  NetworkService.swift
//  OpenWeatherMap
//
//  Created by Walid on 12/3/2023.
//

import Foundation

public enum FetchError: Error {
    case ParsingError
    case APIError
}

public protocol NetworkService {
    var gateway: HostGateway {get set}
    func fetchWeather(from url: String, completion: @escaping (Result<OpenWeatherMapMinimalResponseModel?, FetchError>) -> Void)
}

struct NetworkServiceImplementation: NetworkService {
    
    var gateway: HostGateway
    
    init(gateway: HostGateway) {
        self.gateway = gateway
    }
    
    func fetchWeather(from url: String, completion: @escaping (Result<OpenWeatherMapMinimalResponseModel?, FetchError>) -> Void) {
        
        gateway.getData(url: url) { result in
            switch result{
            case .failure(let error):
                print(error)
                completion(.failure(FetchError.APIError))
                break
            case .success(let data):
                guard let data = data else {
                    completion(.failure(FetchError.APIError))
                    return
                }
                do {
                    let locationWeather = try JSONDecoder().decode(OpenWeatherMapMinimalResponseModel.self, from: data)
                    completion(.success(locationWeather))
                }
                catch {
                    completion(.failure(FetchError.ParsingError))
                }
                break
            }
        }
        
    }
    
}
