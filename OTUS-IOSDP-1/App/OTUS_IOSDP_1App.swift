//
//  OTUS_IOSDP_1App.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 03/07/2021.
//

import SwiftUI
import URLImageStore
import URLImage

@main
struct OTUS_IOSDP_1App: App {
    let urlImageService = URLImageService(fileStore: URLImageFileStore(),
                                             inMemoryStore: URLImageInMemoryStore())

    var body: some Scene {
        WindowGroup {
//            CountryScreen()
            MainScreen()
                .environmentObject(Router())
                .environmentObject(CountriesService())
                .environment(\.urlImageService, urlImageService)
                .accentColor(.orange )
        }
    }
}
