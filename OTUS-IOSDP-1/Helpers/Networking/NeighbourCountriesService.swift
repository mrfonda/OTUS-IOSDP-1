//
//  NeighbourCountriesService.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 26/07/2021.
//

import Foundation
import Combine

// MARK: - NeighbourElement
struct NeighbourCountry: Codable, Identifiable {
    let countryCode, countryName: String

    var id: String {
        countryCode
    }
    
    enum CodingKeys: String, CodingKey {
        case countryCode = "country_code"
        case countryName = "country_name"
    }
}

typealias NeighbourCountries = [NeighbourCountry]

final class NeighbourCountriesService: ObservableObject {
    typealias Output = Result<NeighbourCountries, Error>

    @Published private(set) var output = Output.success([])

    @Input var countryCode = ""
   
    private let loader: NeighbourCountriesLoader

    init(countryCode: String, loader: NeighbourCountriesLoader = .init()) {
        self.countryCode = countryCode
        self.loader = loader
        configureDataPipeline()
        self.countryCode = countryCode
    }
}


private extension NeighbourCountriesService {
    func configureDataPipeline() {
        $countryCode
            .dropFirst()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map { [loader] query in
                loader.loadNeigbours(forCountry: self.countryCode)
                .asResult()
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .assign(to: &$output)
    }
}
