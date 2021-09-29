//
//  RandomCountryService.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 26/09/2021.
//

import Foundation
import Resolver

class RandomCountryService {
    @Injected var countriesService: CountriesService
 
    private func randomizeFromService() -> Country? {
        countriesService.countries.randomElement()
    }
    
    func fetchRandomCountry() async -> Country?{
        guard !countriesService.countries.isEmpty
        else {
            await countriesService.loadCountries()
            return randomizeFromService()
        }
        
        return randomizeFromService()
    }
}
