//
//  Holiday.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 04/07/2021.
//

import Foundation

public struct Holiday: Codable, Identifiable {
    public var id: String { name }
    public let name: String
    public let description: String
    public let date: Date
    public let type: [String]
    public let locations: String
    
    enum CodingKeys: String, CodingKey {
        case name, description, date, type, locations
    }
    
    enum DateCodingKeys: String, CodingKey {
        case iso
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
           
        
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
        type = try values.decode([String].self, forKey: .type)
        date = try values
            .nestedContainer(keyedBy: DateCodingKeys.self, forKey: .date)
            .decode(Date.self, forKey: .iso)
        locations = try values.decode(String.self, forKey: .locations)
    }
}
