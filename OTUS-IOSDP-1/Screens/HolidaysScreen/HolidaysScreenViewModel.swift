//
//  HolidaysScreenViewModel.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 03/07/2021.
//

import Foundation
import Combine
import Core
import Resolver

class HolidaysScreenViewModel: ObservableObject {
    typealias Output = Result<[Holiday], Error>

    @Published private(set) var output = Output.success([])

    @Input var countryCode = ""
    @Input var year = Calendar.current.component(.year, from: Date())
    
    @Injected var loader: HolidaysLoader

    init(countryCode: String) {
        self.countryCode = countryCode
        self.loader = loader
        configureDataPipeline()
        self.countryCode = countryCode
    }
}

private extension HolidaysScreenViewModel {
    func loadHolidays() {
        loader.loadHolidays(forCountry: countryCode, year: year)
              .asResult()
              .receive(on: DispatchQueue.main)
              .assign(to: &$output)
    }
}

private extension HolidaysScreenViewModel {
    func configureDataPipeline() {
        $countryCode
            .dropFirst()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .combineLatest($year)
            .compactMap { [loader] query, filter in
                loader.loadHolidays(
                    forCountry: self.countryCode,
                    year: self.year)
                .asResult()
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .assign(to: &$output)
    }
}
