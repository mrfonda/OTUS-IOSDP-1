//
//  CountriesLoader.swift
//  
//
//  Created by Vladislav Dorfman on 14/08/2021.
//

import Foundation

public protocol CountriesLoader {
    func loadCountries(completion: @escaping ([Country])->Void)
    func loadCountries() async -> [Country]
}

public class CountriesLocaleLoader: CountriesLoader {
    public func loadCountries() async -> [Country] {
        return loadLocaleCountries()
    }
    
    public func loadCountries(completion: @escaping ([Country]) -> Void) {
        completion(loadLocaleCountries())
    }
    
    public init() {}
    
    private func loadLocaleCountries() -> [Country] {
        var countries: [Country] = .init()
        
        Locale.isoRegionCodes.forEach { code in
            let name = Locale.current.localizedString(forRegionCode: code)
           
            let country = Country(
                id: code,
                name: name ?? code)
            
            countries.append(country)
        }
        return countries
    }
}
