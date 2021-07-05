//
//  DashboardScreen.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 03/07/2021.
//

import SwiftUI

struct DashboardScreen: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var countriesService: CountriesService
    
    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            
            Text("Holidays in")
                .font(Font.headline)
            
            
            if let lastCountry = router.lastCountry {
                
                VStack(alignment: .center, spacing: 16) {
                    Text("Last seen country:")
                    CountryBubbleView(country: lastCountry)
                        .onTapGesture {
                            
                            withAnimation {
                                router.openedCountryCode =  lastCountry.id
                                
                                router.mainTabSelection = MainScreen.MainScreenTabs.countries.rawValue
                            }
                            
                        }
                }
            }
            
            if let randomCountry = countriesService.randomCountry {
                VStack(alignment: .center, spacing: 16) {
                    Text("Random country:")
                    CountryBubbleView(country: randomCountry)
                        .onTapGesture {
                            
                            
                            
                            withAnimation {
                                router.openedCountryCode =  randomCountry.id
                                router.mainTabSelection = MainScreen.MainScreenTabs.countries.rawValue
                            }
                        }
                }
            }
        }
    }
}

struct DashboardScreen_Previews: PreviewProvider {
    static var previews: some View {
        DashboardScreen()
    }
}
