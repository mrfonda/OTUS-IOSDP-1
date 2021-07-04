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

    @Input var country = ""
    @Input var year = Calendar.current.component(.year, from: Date())
    
    private let loader: HolidaysLoader

    init(loader: HolidaysLoader = .init()) {
        self.loader = loader
        configureDataPipeline()
    }
}

private extension HolidaysModel {
    func loadHolidays() {
        loader.loadHolidays(forCountry: country, year: year)
              .asResult()
              .receive(on: DispatchQueue.main)
              .assign(to: &$output)
    }
}

private extension HolidaysModel {
    func configureDataPipeline() {
        $country
            .dropFirst()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .combineLatest($year)
            .map { [loader] query, filter in
                loader.loadHolidays(
                    forCountry: self.country,
                    year: self.year)
                .asResult()
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .assign(to: &$output)
    }
}
