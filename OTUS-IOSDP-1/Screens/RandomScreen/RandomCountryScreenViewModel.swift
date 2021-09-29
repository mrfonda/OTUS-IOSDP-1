//
//  RandomCountryScreenViewModel.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 26/09/2021.
//

import Resolver
import Combine
import Foundation

class RandomCountryScreenViewModel: ObservableObject {
    @Published var randomCountry: Country?
    
    @Injected var randomCountryService: RandomCountryService
    @Published var router: Router = Resolver.resolve()
    
    func fetchRandomCountry() async {
        randomCountry = await randomCountryService.fetchRandomCountry()
    }
    
    func open() {
        router.openedCountryCode =  randomCountry?.id
        router.mainTabSelection = MainTab.countries.rawValue
    }
}
