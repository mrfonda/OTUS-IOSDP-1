//
//  Country.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 14/08/2021.
//

import Foundation
import Core

public struct Country: Identifiable {
    public let id: String
    public let name: String
    public let imageURL: URL?
    init(coreCountry: Core.Country) {
        id = coreCountry.id
        name = coreCountry.name
        
        let imageURLString = "https://www.countryflags.io/\(id)/flat/64.png"
        imageURL = URL(string: imageURLString)
    }
    
    init(id: String,
         name: String,
         imageURL: URL?) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
    }
}
