//
//  HolidaysModel.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 03/07/2021.
//

import Foundation

struct HolidaysResponse: Codable {
    enum CodingKeys: String, CodingKey {
    case response
        case holidays
    }
    
    init(from decoder: Decoder) throws {
        
    }
}

struct Holyday: Codable, Identifiable {
    var id: String { name }
    let name: String
    let description: String
//    let country: Country
    let date: Date
    let type: [String]
    let locations: String
    let states: String
}


import Foundation
import Combine
class HolidaysModel {
    enum APIError: Error {
        case incorrectURL(url: String)
        case apiError(reason: String)
        case serializationError
    }
    
    static func fetchNumbers(urlString: String) throws -> Result<[Holyday], APIError>  {
        guard let url: URL = URL(string: urlString)
        else {
            throw APIError.incorrectURL(url: urlString)
        }
        
        let urlRequest = URLRequest(url: url)
        
        return URLSession.DataTaskPublisher(request: urlRequest, session: .shared)
            .tryMap { data, response in
                guard
                    let httpResponse = response as? HTTPURLResponse,
                    200..<300 ~= httpResponse.statusCode else {
                    throw APIError.apiError(reason: "No response or status code unacceptible")
                }
                
                return data
            }
            .mapError { error -> APIError in
                if let error = error as? APIError {
                    return error
                } else {
                    return APIError.apiError(reason: error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
            .decode(type: [Holyday].self, decoder: JSONDecoder())
            .mapError { error -> APIError in
                if let error = error as? APIError {
                    return error
                } else {
                    return APIError.apiError(reason: error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
    
    private init() {
        
    }
    
    
    
}

