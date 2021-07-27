//
//  CountryScreen.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 23/07/2021.
//

import SwiftUI

struct CountryScreen: View {
    @ObservedObject var model: CountryScreenModel
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
                        NewsScreen(model: NewsScreenModel(queryString: searchQuery))
                            .tag(tab.id)
                    case .holidays(let code):
                        HolidaysScreen(viewModel: HolidaysModel(countryCode: code))
                            .tag(tab.id)
                    case .neighbours(let code):
                        NeighboursView()
                            .environmentObject(NeighbourCountriesService(countryCode: code))
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
                CountryThumbnailView(country: model.country)
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
        @EnvironmentObject var neighborsService: NeighbourCountriesService
        
        var body: some View {
            switch neighborsService.output {
            case .success(let neighbours):
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 16)], alignment: .leading) {
                        if neighbours.count > 0 {
                            ForEach(neighbours) { neighbour in
                                NavigationLink(destination: CountryScreen(model: CountryScreenModel(country: Country(
                                                                                                        id: neighbour.countryCode,
                                                                                                        name: neighbour.countryName,
                                                                                                        imageURL: URL(string: "https://www.countryflags.io/\(neighbour.countryCode)/flat/64.png"))), router: EnvironmentObject<Router>())
                                ) {
                                    CountryThumbnailView(country: Country(
                                                            id: neighbour.countryCode,
                                                            name: neighbour.countryName,
                                                            imageURL: URL(string: "https://www.countryflags.io/\(neighbour.countryCode)/flat/64.png")))
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

//struct CountryScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//        CountryScreen()
//            .environmentObject(CountryScreenModel())
//        }
//    }
//}
