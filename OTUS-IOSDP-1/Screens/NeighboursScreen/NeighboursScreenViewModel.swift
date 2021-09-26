//
//  NeighboursScreenViewModel.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 26/07/2021.
//

import Foundation
import Combine
import Core
import Resolver

final class NeighboursScreenViewModel: ObservableObject {
    typealias Output = Result<NeighbourCountries, Error>

    @Published private(set) var output = Output.success([])

    @Input var countryCode = ""
   
    @Injected var loader: NeighbourCountriesLoader!

    init(countryCode: String) {
        self.countryCode = countryCode
        self.loader = loader
        configureDataPipeline()
        self.countryCode = countryCode
    }
}


private extension NeighboursScreenViewModel {
    func configureDataPipeline() {
        $countryCode
            .dropFirst()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .compactMap { [loader] query in
                loader?.loadNeigbours(forCountry: self.countryCode)
                .asResult()
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .assign(to: &$output)
    }
}
