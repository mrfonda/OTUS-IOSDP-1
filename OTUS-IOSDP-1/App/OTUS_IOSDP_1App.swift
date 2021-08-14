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

@main
struct OTUS_IOSDP_1App: App {
    let urlImageService = URLImageService(fileStore: URLImageFileStore(),
                                             inMemoryStore: URLImageInMemoryStore())

    init() {
        ServiceLocator.shared
            .addService(
                service: CountriesLocaleLoader() as CountriesLoader)
        ServiceLocator.shared
            .addService(
                service: CalendarificHolidaysLoader(
                    apiKey: AppSettings.shared.holidaysAPIKey) as HolidaysLoader)
        ServiceLocator.shared
            .addService(
                service: GeoDataSourceNeighbourCountriesLoader(
                    apiKey: AppSettings.shared.neighboursAPIKey) as NeighbourCountriesLoader)
    }
    
    var body: some Scene {
        WindowGroup {
            MainScreen()
                .environmentObject(Router())
                .environmentObject(CountriesScreenViewModel())
                .environment(\.urlImageService, urlImageService)
                .accentColor(.orange )
        }
    }
}
