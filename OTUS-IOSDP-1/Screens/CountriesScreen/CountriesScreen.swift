//
//  CountriesScreen.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 03/07/2021.
//

import SwiftUI
import URLImage

struct CountriesScreen: View {
    @EnvironmentObject var countriesService: CountriesService
    @EnvironmentObject var router: Router
    @EnvironmentObject var holidaysViewModel: HolidaysModel
    
    @State var isShowingHolidaysScreen: Bool = false
    
    func holidayScreen(country: Country) -> some View {
        
        return HolidaysScreen(
            viewModel: holidaysViewModel)
            .onAppear() {
                
                router.lastCountry = country
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    CountryThumbnailView(country: country)
                }
            }
            .navigationTitle(country.name)
    }
    
    var navigationLink: NavigationLink<EmptyView, HolidaysScreen>? {
        if let code = router.openedCountryCode,
           let country = countriesService.country(byCode: code),
           let view = holidayScreen(country: country) as? HolidaysScreen {
            return NavigationLink(destination: view, isActive: $isShowingHolidaysScreen) { EmptyView() }
        } else {
            return nil
        }
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            NavigationView {
                VStack {
                    SearchView(searchModel: countriesService)
                    List(countriesService.filtered) { country in
                            CountryThumbnailView(country: country)
                                .frame(height: 48)
                                .onTapGesture {
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    router.openedCountryCode =  country.id
                                    holidaysViewModel.country = country.id
                                }
                                .background(NavigationLink(destination: holidayScreen(country: country), tag: country.id, selection: $router.openedCountryCode) { EmptyView() })
                    }.listStyle(PlainListStyle())
                    .background(
                        navigationLink
                    )
                    .onAppear() {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        isShowingHolidaysScreen = false
                        if let code = router.openedCountryCode {
                            withAnimation() {
                                proxy.scrollTo(code)
                                holidaysViewModel.country = code
                                isShowingHolidaysScreen = true
                            }
                        }
                    }
                }
                
                
                .navigationBarTitle("Explore holidays in...")
            }
        }
    }
}

struct CountriesScreen_Previews: PreviewProvider {
    static var previews: some View {
        CountriesScreen()
    }
}
