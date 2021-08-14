//
//  CountriesScreenViewModel.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 03/07/2021.
//

import Combine
import Foundation
import UIKit
import Core

class CountriesScreenViewModel: ObservableObject {
    
    @Published var countries: [Country] = []
    
    @Published var filtered: [Country] = []
    
    @Injected var loader: CountriesLoader!
    
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
    
    func loadCountries() {
        loader.loadCountries { [weak self] countries in
            self?.countries = countries.map{Country(coreCountry: $0)}
            self?.filtered = self?.countries ?? .init()
        }
    }
}
