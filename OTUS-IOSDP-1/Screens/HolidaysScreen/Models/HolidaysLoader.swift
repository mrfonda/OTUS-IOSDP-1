//
//  HolidaysLoader.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 04/07/2021.
//

import Foundation
import Combine

struct HolidaysLoader {
    private let urlSession = URLSession.shared
    private let urlString: String = "https://calendarific.com/api/v2/holidays"
    private let apiKey: String = "551995c63a567cacbbffa61f76ec8b440b9ecaa1758b5b0bb8fed4f614b58209"
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
    
        decoder.dateDecodingStrategyFormatters = [
            DateFormatter.RFC3339DateFormatterDefault,
            DateFormatter.iso8601Full,
            DateFormatter.iso8601Full2,
            DateFormatter.yyyyMMdd
        ]
        
        return decoder
    }()
    
    func loadHolidays(
        forCountry country: String,
        year: Int
    ) -> AnyPublisher<[Holiday], Error> {

        guard
            var urlComponents = URLComponents(string: urlString)
        else {
            return Just([])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "year", value: String(year))
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
            .decode(type: HolidaysResponse.self, decoder: decoder)
            .map(\.holidays)
            .map {
                print($0)
                return $0
            }
            .eraseToAnyPublisher()
    }
}


