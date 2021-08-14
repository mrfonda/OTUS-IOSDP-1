//
//  MainScreen.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 03/07/2021.
//

import SwiftUI
import Combine
import NavigationStack

struct MainScreen: View {
    enum MainScreenTabs: Int, CaseIterable, Identifiable {
        case dashboard
        case countries
//        case neighbours //the api is down
        case third
        
        var id: Int { rawValue }
    }
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var countriesService: CountriesScreenViewModel
    
    var body: some View {
        TabView(selection: $router.mainTabSelection) {
            ForEach(MainScreenTabs.allCases) { tab in
                switch tab {
                case .dashboard:
                    DashboardScreen().tabItem {
                        Image(systemName: "map")
                        Text("Dashboard")

                    }.tag(tab.rawValue)
                case .countries:
                    NavigationView {
                        CountriesScreen()
                        Text("Select a country")
                    }
                    .tabItem {
                        Image(systemName: "globe")
                        Text("Countries")
                    }
                    .tag(tab.rawValue)
//                case .neighbours:
//                    NeighboursScreen(neighborsService: NeighboursScreenViewModel(countryCode: "RU"))
//                        .environmentObject(NavigationStack())
//                    .tabItem {
//                        Image(systemName: "globe")
//                        Text("Neighbours")
//                    }
//                    .tag(tab.rawValue)
                case .third:
                    ThirdScreen().tabItem {
                        Image(systemName: "gift")
                        Text("Random Modal")
                    }.tag(tab.rawValue)
                }
            }
        }
        .onAppear() {
            countriesService.loadCountries()
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
