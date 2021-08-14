//
//  File.swift
//  
//
//  Created by Vladislav Dorfman on 14/08/2021.
//

import Foundation

public struct NeighbourCountry: Codable, Identifiable {
    public let countryCode, countryName: String

    public var id: String {
        countryCode
    }
    
    enum CodingKeys: String, CodingKey {
        case countryCode = "country_code"
        case countryName = "country_name"
    }
}

public typealias NeighbourCountries = [NeighbourCountry]

