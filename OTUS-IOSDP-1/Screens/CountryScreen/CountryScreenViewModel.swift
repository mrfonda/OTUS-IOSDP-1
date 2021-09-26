//
//  CountryScreenViewModel.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 23/07/2021.
//

import Foundation
import SwiftUI
import Combine

final class CountryScreenViewModel: ObservableObject {
    struct Tab: Identifiable {
        let id: Int
        let title: String
        let type: Type
        
        enum `Type` {
            case holidays(code: String)
            case neighbours(code: String)
            case news(searchQuery: String)
        }
    }

    
    private(set) var country: Country
    
    var didChange = PassthroughSubject<Void,Never>()
        
    @Published var tabs: [Tab] = []
    @Published var selectedTab: Int = 0
    
    init(country: Country) {
        self.country = country
        tabs = [
            Tab(id: 0, title: "holidays", type: .holidays(code: country.id))
        ]
        
        tabs.append(
            contentsOf: [
                makeNewsTab(forTitle: "politics", id: 1),
                makeNewsTab(forTitle: "weather", id: 2),
                makeNewsTab(forTitle: "economy", id: 3)])
    }
    
    private func makeNewsTab(forTitle title: String, id: Int) -> Tab {
        Tab(
            id: id,
            title: title,
            type: .news(searchQuery: country.name + " " + title)
        )
    }
    
    func addNewsTab(withTitle title: String) {
        let newTopic = makeNewsTab(forTitle: title, id: tabs.count)
        tabs.append(newTopic)
    }
}
