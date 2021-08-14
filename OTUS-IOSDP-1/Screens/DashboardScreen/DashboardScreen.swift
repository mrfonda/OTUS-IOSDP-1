//
//  DashboardScreen.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 03/07/2021.
//

import SwiftUI
import UIComponents

struct DashboardScreen: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var countriesService: CountriesScreenViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            
            Text("Information about countries")
                .font(Font.headline)
            
            
            if let lastCountry = router.lastCountry {
                
                VStack(alignment: .center, spacing: 16) {
                    Text("Last seen country:")
                    CountryBubbleView(id: lastCountry.id, name: lastCountry.name, imageURL: lastCountry.imageURL)
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
                    CountryBubbleView(id: randomCountry.id, name: randomCountry.name, imageURL: randomCountry.imageURL)
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
