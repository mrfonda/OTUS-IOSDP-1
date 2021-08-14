//
//  HolidaysLoader.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 04/07/2021.
//

import Foundation
import Combine

public protocol NeighbourCountriesLoader {
    func loadNeigbours(
        forCountry country: String
    ) -> AnyPublisher<NeighbourCountries, Error>
}

public struct GeoDataSourceNeighbourCountriesLoader: NeighbourCountriesLoader {
    private let urlSession = URLSession.shared
    private let urlString: String = "https://api.geodatasource.com/v2/neighboring-countries"
    public let apiKey: String
    private let decoder: JSONDecoder = JSONDecoder()
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    public func loadNeigbours(
        forCountry country: String
    ) -> AnyPublisher<NeighbourCountries, Error> {

        guard
            var urlComponents = URLComponents(string: urlString)
        else {
            return Just([])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "country_code", value: country)
        ]

        guard
            let url = urlComponents.url
        else {
            return Just([])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
       
        print(url.absoluteString)
        let urlRequest = URLRequest(url: url)
        
//        urlRequest.httpBody = try? JSONEncoder()
//            .encode(["apiKey": apiKey,
//                     "format": "json",
//                     "country_code": country])
        
        
        return urlSession.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .map { print(String(data:$0, encoding: .utf8)); return $0 }
            .decode(type: NeighbourCountries.self, decoder: decoder)
            
            .eraseToAnyPublisher()
    }
}


