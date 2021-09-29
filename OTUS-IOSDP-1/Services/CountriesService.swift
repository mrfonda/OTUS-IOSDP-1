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

    func loadCountries() async -> [Country]  {
        countries = await loader.loadCountries().map { Country(coreCountry: $0) }

        return countries
    }
}
