//
//  CountriesService.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 26/09/2021.
//

import Foundation
import Resolver
import Core

class CountriesService: ObservableObject {
    @Published var countries: [Country] = []

    @Injected var loader: CountriesLoader

    func loadCountries(completion: @escaping ()->Void) {
        loader.loadCountries { [weak self] countries in
            self?.countries = countries.map { Country(coreCountry: $0) }
            completion()
        }
    }
}
