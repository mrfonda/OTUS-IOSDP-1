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
import Resolver

class CountriesScreenViewModel: ObservableObject {
    @Published var countries: [Country] = []
    @Published var filtered: [Country] = []
    
    @Injected var countriesService: CountriesService
    
    init() {
        countries = countriesService.countries
        filtered = countries
    }
    
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
        countriesService.loadCountries { [weak self] in
            guard let self = self else { return }
            self.countries = self.countriesService.countries
            self.filtered = self.countries
        }
    }
}
