//
//  Router.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 03/07/2021.
//

import Combine

public class Router: ObservableObject {
    @Published var mainTabSelection: Int = MainScreen.MainScreenTabs.allCases.first!.rawValue
    @Published var lastCountry: Country?
    @Published var openedCountryCode: String?
    @Published var isShowingCountryScreen: Bool = false
}
