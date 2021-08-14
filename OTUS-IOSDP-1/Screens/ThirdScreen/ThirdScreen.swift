//
//  ThirdScreen.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 04/07/2021.
//

import SwiftUI
import UIComponents

struct ThirdScreen: View {
    @State private var isShowing = false
    @EnvironmentObject var router: Router
    @EnvironmentObject var countriesService: CountriesScreenViewModel
    
    var body: some View {

        Button {
                    isShowing.toggle()
                } label: {
                    Text("Show Random").font(.largeTitle)
                }.fullScreenCover(isPresented: $isShowing) {
                    if let randomCountry = countriesService.randomCountry {
                        Text("Random country:")
                        CountryBubbleView(id: randomCountry.id,
                                            name: randomCountry.name,
                                            imageURL: randomCountry.imageURL)
                            .onTapGesture {
                                isShowing.toggle()
                                router.openedCountryCode =  randomCountry.id
                                
                                router.mainTabSelection = MainScreen.MainScreenTabs.countries.rawValue
                                
                            }
                    }
                }
    }
}

struct ThirdScreen_Previews: PreviewProvider {
    static var previews: some View {
        ThirdScreen()
    }
}
