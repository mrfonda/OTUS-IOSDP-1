//
//  HolidaysModel.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 03/07/2021.
//

import Foundation
import Combine

class HolidaysModel: ObservableObject {
    typealias Output = Result<[Holiday], Error>

    @Published private(set) var output = Output.success([])

    @Input var countryCode = ""
    @Input var year = Calendar.current.component(.year, from: Date())
    
    private let loader: HolidaysLoader

    init(countryCode: String, loader: HolidaysLoader = .init()) {
        self.countryCode = countryCode
        self.loader = loader
        configureDataPipeline()
        self.countryCode = countryCode
    }
}

private extension HolidaysModel {
    func loadHolidays() {
        loader.loadHolidays(forCountry: countryCode, year: year)
              .asResult()
              .receive(on: DispatchQueue.main)
              .assign(to: &$output)
    }
}

private extension HolidaysModel {
    func configureDataPipeline() {
        $countryCode
            .dropFirst()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .combineLatest($year)
            .map { [loader] query, filter in
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
