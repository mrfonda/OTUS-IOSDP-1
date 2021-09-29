//
//  MainScreen.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 03/07/2021.
//

import SwiftUI
import Combine

enum MainTab: Int, CaseIterable, Identifiable, Hashable {
    case dashboard
    case countries
    case random
    
    var id: Int { rawValue }
}

struct MainScreen: View {
   
    @ObservedObject var viewModel: MainScreenViewModel
    @EnvironmentObject var router: Router
    
    var dashboardViewModel: DashboardScreenViewModel = DashboardScreenViewModel()
    var randomViewModel: RandomCountryScreenViewModel = RandomCountryScreenViewModel()
    var countriesScreenViewModel: CountriesScreenViewModel = CountriesScreenViewModel()
    
    var body: some View {
        TabView(selection: $router.mainTabSelection) {
            ForEach(MainTab.allCases) { tab in
                switch tab {
                case .dashboard:
                    DashboardScreen().tabItem {
                        Image(systemName: "map")
                        Text("Dashboard")

                    }.tag(tab.rawValue)
                    .environmentObject(dashboardViewModel)
                case .countries:
                    NavigationView {
                        CountriesScreen()
                            .environmentObject(countriesScreenViewModel)
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
                case .random:
                    RandomCountryScreen(viewModel: RandomCountryScreenViewModel()).tabItem {
                        Image(systemName: "gift")
                        Text("Random Modal")
                    }.tag(tab.rawValue)
                }
            }
        }
        .onAppear() {
            if #available(iOS 15.0, macOS 12.0, *) {
                async {
                    await countriesScreenViewModel.loadCountries()
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

