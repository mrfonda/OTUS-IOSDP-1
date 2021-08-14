//
//  HolidaysLoader.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 04/07/2021.
//

import Foundation
import Combine

public protocol HolidaysLoader {
    func loadHolidays(
        forCountry country: String,
        year: Int
    ) -> AnyPublisher<[Holiday], Error>
}

public struct CalendarificHolidaysLoader: HolidaysLoader {
    private let urlSession = URLSession.shared
    private let urlString: String = "https://calendarific.com/api/v2/holidays"
    public let apiKey: String
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
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
    
    public func loadHolidays(
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


