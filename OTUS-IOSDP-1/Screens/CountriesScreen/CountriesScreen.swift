//
//  CountriesScreen.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 03/07/2021.
//

import SwiftUI
import Combine
import UIComponents

struct CountriesScreen: View {
    @EnvironmentObject var countriesService: CountriesScreenViewModel
    @EnvironmentObject var router: Router
    
    @State var openedCountry: String? = nil
    
    func countryScreen(country: Country) -> some View {
        return CountryScreen(model: CountryScreenViewModel(country: country))
            .onAppear() {
                router.lastCountry = country
            }
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            
            VStack {
                SearchView($countriesService.searchText)
                List(countriesService.filtered) { country in
                    NavigationLink(
                        destination: countryScreen(country: country),
                        tag: country.id, selection: $openedCountry, label: {
                            CountryThumbnailView(id: country.id, name: country.name, imageURL: country.imageURL)
                                .frame(height: 48)
                                .onTapGesture {
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    router.openedCountryCode = country.id
                                    openedCountry = country.id
                                }
                        })
                    
                    
                }
                .onReceive(Just(router.openedCountryCode).delay(for: 0, scheduler: DispatchQueue.main)) {
                    if let code = $0, openedCountry != code {
                        //                            countriesService.searchText = ""
                        withAnimation() {
                            proxy.scrollTo(code)
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                                openedCountry = router.openedCountryCode
                            }
                        }
                    }
                    
                    if $0 == nil {
                        openedCountry = nil
                    }
                }
                .listStyle(PlainListStyle())
                .onAppear() {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            }
            .navigationBarTitle("Explore holidays in...")
        }
    }
}

struct CountriesScreen_Previews: PreviewProvider {
    static var previews: some View {
        CountriesScreen()
    }
}
