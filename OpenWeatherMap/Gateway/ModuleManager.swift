//
//  ModuleManager.swift
//  OpenWeatherMap
//
//  Created by Walid on 12/3/2023.
//

import Foundation

enum OpenWeatherMapServiceError: Error {
    case ParametersNotSet
}

protocol ModuleManager {
    var networkService: NetworkService {get set}
    func fetchWeather(for request: OpenWeatherMapRequestModel, completion: @escaping (OpenWeatherMapMinimalResponseModel?, String?) -> Void) throws
}

class ModuleManagerImplementation: ModuleManager {
    
    var networkService: NetworkService
    private var configName: String?
    
    init(gateway: HostGateway, configName: String = "Constants") {
        self.networkService = NetworkServiceImplementation(gateway: gateway)
    }
    
    func fetchWeather(for request: OpenWeatherMapRequestModel, completion: @escaping (OpenWeatherMapMinimalResponseModel?, String?) -> Void) throws {
        
        guard let path = Bundle.main.path(forResource: configName, ofType: "plist"), let properties = NSDictionary(contentsOfFile: path) else {
            throw OpenWeatherMapServiceError.ParametersNotSet
        }
        
        guard let baseUrl = properties["baseUrl"] as? String, let apiKey = properties["APIKey"] as? String else {
            throw OpenWeatherMapServiceError.ParametersNotSet
        }
        
        //Prepare Url
        var url = baseUrl + "?appid=\(apiKey)"
        url.append(request.parametersEncoded)
        
        //call network
        self.networkService.fetchWeather(from: url) { result in
            switch result{
            case .failure(let fetchError):
                switch fetchError{
                case .ParsingError:
                    completion(nil, "issue_happened_please_contact_dev")
                    break
                case .APIError:
                    completion(nil, "weather_provider_issue_please_try_later")
                    break
                }
                break
            case .success(let locationWeather):
                completion(locationWeather, nil)
                break
            }
        }
    }
}
