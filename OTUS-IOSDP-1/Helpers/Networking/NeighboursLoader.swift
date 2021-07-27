//
//  HolidaysLoader.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 04/07/2021.
//

import Foundation
import Combine

struct NeighbourCountriesLoader {
    private let urlSession = URLSession.shared
    private let urlString: String = "https://api.geodatasource.com/neighboring-countries"
    private let apiKey: String = "57QWK3M56WJLOVLE3DG0O26HEEN8M94J"
    private let decoder: JSONDecoder = JSONDecoder()
    
    func loadNeigbours(
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
            URLQueryItem(name: "country_code", value: country),
        ]

        guard
            let url = urlComponents.url
        else {
            return Just([])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
       
        
        return urlSession.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: NeighbourCountries.self, decoder: decoder)
            .map {
                print($0)
                return $0
            }
            .eraseToAnyPublisher()
    }
}


