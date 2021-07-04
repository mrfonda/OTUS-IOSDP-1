//
//  CountriesService.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 03/07/2021.
//

import Combine
import Foundation
import UIKit

struct Country: Identifiable {
    let id: String
    let name: String
    let imageURL: URL?
}

class CountriesService: ObservableObject {
    
    @Published var countries: [Country] = []
    
    @Published var filtered: [Country] = []
    
    var searchText: String = "" {
        didSet {
            guard
                !searchText.isEmpty
            else {
                filtered = countries
                return
            }
            filtered = countries.filter({ country in
                country.name.contains(searchText)
            })
        }
    }
    
    @objc func textFieldDidChange(_ tf: UITextField) {
        searchText = tf.text ?? ""
    }
    
    var randomCountry: Country? { countries.randomElement() }
    
    func country(byCode: String) -> Country? {
        return countries.first { country in
            country.id == byCode
        }
    }
    
    init () {
        Locale.isoRegionCodes.forEach { code in
            let name = Locale.current.localizedString(forRegionCode: code)
            let imageURLString = "https://www.countryflags.io/\(code)/flat/64.png"
            
            let country = Country(
                id: code,
                name: name ?? code,
                imageURL: URL(string: imageURLString))
            
            countries.append(country)
        }
        filtered = countries
    }
}
