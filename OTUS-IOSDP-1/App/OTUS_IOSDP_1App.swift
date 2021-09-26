//
//  OTUS_IOSDP_1App.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 03/07/2021.
//

import SwiftUI
import URLImageStore
import URLImage
import Core
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        defaultScope = .graph
        register { RandomCountryService() }
        register { CountriesService() }
            .scope(.application)
        register { CountriesLocaleLoader() as Core.CountriesLoader }
        register {
            GeoDataSourceNeighbourCountriesLoader(
            apiKey: AppSettings.shared.neighboursAPIKey) as NeighbourCountriesLoader
        }
        register {
            CalendarificHolidaysLoader(
                apiKey: AppSettings.shared.holidaysAPIKey) as HolidaysLoader
        }
        
        register { Router() }
            .scope(.application)
    }
}

@main
struct OTUS_IOSDP_1App: App {
    let urlImageService = URLImageService(fileStore: URLImageFileStore(),
                                             inMemoryStore: URLImageInMemoryStore())
    
    @Injected var router: Router
    
    var body: some Scene {
        WindowGroup {
            MainScreen(viewModel: .init())
                .environmentObject(router)
                .environment(\.urlImageService, urlImageService)
                .accentColor(.orange )
        }
    }
}
