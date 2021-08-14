//
//  CountryScreen.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 23/07/2021.
//

import SwiftUI
import UIComponents

struct CountryScreen: View {
    @ObservedObject var model: CountryScreenViewModel
    @EnvironmentObject var router: Router
   
    @State private var isShowingAlert: Bool = false
    @State var selected: Int = 0
    var body: some View {
        VStack {
            Picker("Options", selection: $selected) {
                ForEach(model.tabs) { tab in
                    Text(tab.title)
                        .tag(tab.id)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
                
            TabView(selection: $selected) {
                ForEach(model.tabs) { tab in
                    switch tab.type {
                    case .news(let searchQuery):
                        NewsScreen(model: NewsScreenViewModel(queryString: searchQuery))
                            .tag(tab.id)
                    case .holidays(let code):
                        HolidaysScreen(viewModel: HolidaysScreenViewModel(countryCode: code))
                            .tag(tab.id)
                    case .neighbours(let code):
                        NeighboursView()
                            .environmentObject(NeighboursScreenViewModel(countryCode: code))
                            .tag(tab.id)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            
            
        }
        .alert(
            isPresented: $isShowingAlert,
            TextAlert(title: "Enter the news topic", action: {
                if let topicTitle = $0, topicTitle.count > 0 {
                    model.addNewsTab(withTitle: topicTitle)
                    model.didChange.send()
                }
            }))
        .toolbar {
            ToolbarItem(placement: .principal) {
                CountryThumbnailView(
                    id: model.country.id,
                    name: model.country.name,
                    imageURL: model.country.imageURL)
            }
        }
        .navigationTitle(model.country.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing: Button(action: {
                isShowingAlert = true
            }, label: {
                Image(systemName: "text.badge.plus")
            }))
        .onDisappear() {
            router.openedCountryCode = nil
        }
    }
    
    
    struct NeighboursView: View {
        @EnvironmentObject var neighborsService: NeighboursScreenViewModel
        
        var body: some View {
            switch neighborsService.output {
            case .success(let neighbours):
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 16)], alignment: .leading) {
                        if neighbours.count > 0 {
                            ForEach(neighbours) { neighbour in
                                NavigationLink(
                                    destination: CountryScreen(
                                        model: CountryScreenViewModel(
                                            country: Country(
                                                id: neighbour.countryCode,
                                                name: neighbour.countryName,
                                                imageURL: URL(string: "https://www.countryflags.io/\(neighbour.countryCode)/flat/64.png"))), router: EnvironmentObject<Router>())
                                ) {
                                    CountryThumbnailView(id: neighbour.countryCode,
                                                         name: neighbour.countryName,
                                                         imageURL: URL(string: "https://www.countryflags.io/\(neighbour.countryCode)/flat/64.png"))
                                }
                                
                            }
                        } else {
                            Text("No neighbouring countries")
                        }
                        
                    }
                }
            case .failure(let error):
                Text(error.localizedDescription)
            }
        }
    }
}
