//
//  DashboardScreenViewModel.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 25/09/2021.
//

import Combine
import Foundation
import Resolver

class DashboardScreenViewModel: ObservableObject {
    @Published var randomCountry: Country?
    
    @Injected var randomCountryService: RandomCountryService
    @Injected var router: Router
    
    func fetchRandomCountry() async {
        randomCountry = await randomCountryService.fetchRandomCountry()
    }
    
    func openLast() {
        router.openedCountryCode = router.lastCountry?.id
        router.mainTabSelection = MainTab.countries.rawValue
    }
    
    func openRandom() {
        router.openedCountryCode =  randomCountry?.id
        router.mainTabSelection = MainTab.countries.rawValue
    }
}
