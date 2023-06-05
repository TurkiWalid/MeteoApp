//
//  NetworkHelper.swift
//  MeteoAssignment
//
//  Created by Walid on 12/3/2023.
//  Source: https://gist.github.com/alexpaul/2047b8017891b044577341564f830677
//

import Foundation

enum APIError: Error {
    case badURL(String)
    case networkError(Error)
    case noResponse
    case decodingError(Error)
    
    public func errorMessage() -> String {
        switch self {
        case .badURL(let str):
            return "badURL: \(str)"
        case .networkError(let error):
            return "networkError: \(error)"
        case .noResponse:
            return "no network response"
        case .decodingError(let error):
            return "decoding error: \(error)"
        }
    }
}
//TODO: Add cancellable
final class NetworkHelper {
    static func performDataTask(urlString: String,
                                httpMethod: String,
                                completionHandler: @escaping (APIError?, Data?, HTTPURLResponse?) ->Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(APIError.badURL("\(urlString)"), nil, nil)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                completionHandler(APIError.noResponse, nil, nil)
                return
            }
            print("response status code is \(response.statusCode)")
            if let error = error {
                completionHandler(APIError.networkError(error), nil, response)
            } else if let data = data {
                completionHandler(nil, data, response)
            }
        }.resume()
    }
}
