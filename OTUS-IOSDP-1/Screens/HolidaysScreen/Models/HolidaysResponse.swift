//
//  HolidaysResponse.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 04/07/2021.
//

import Foundation

struct HolidaysResponse: Codable {
    var holidays: [Holiday]
    
    enum CodingKeys: String, CodingKey {
        case holidays
    }
    
    enum ResponseCodingKeys: String, CodingKey {
        case meta
        case response
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ResponseCodingKeys.self)
           
        self.holidays = try values
            .nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
            .decode([Holiday].self, forKey: .holidays)
    }
}
