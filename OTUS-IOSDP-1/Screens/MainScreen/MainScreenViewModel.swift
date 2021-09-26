//
//  MainScreenViewModel.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 18/09/2021.
//

import Foundation
import Combine
import Resolver

final class MainScreenViewModel: ObservableObject {
    @Published var router: Router = Resolver.resolve()
    @Injected var countriesService: CountriesService
}
