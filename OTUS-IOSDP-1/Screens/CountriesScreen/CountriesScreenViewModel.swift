//
//  CountriesScreenViewModel.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 03/07/2021.
//

import Combine
import Foundation
#if !os(macOS)
import UIKit
#else
import AppKit
#endif

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
    
#if !os(macOS)
    @available(iOS 15.0, *)
    @objc func textFieldDidChange(_ tf: UITextField) {
        searchText = tf.text ?? ""
    }
    #else
    @available(macOS 12.0, *)
    @objc func textFieldDidChange(_ tf: NSTextField) {
        searchText = tf.stringValue ?? ""
    }
    #endif
    var randomCountry: Country? { countries.randomElement() }
    
    func country(byCode: String) -> Country? {
        return countries.first { country in
            country.id == byCode
        }
    }
    
    func loadCountries() async {
        
        self.countries = await countriesService.loadCountries()
        self.filtered = self.countries
        
    }
}
