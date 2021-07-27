//
//  NeighboursScreen.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 26/07/2021.
//

import SwiftUI
import NavigationStack

struct NeighboursScreen: View {
    @ObservedObject var neighborsService: NeighbourCountriesService
    @EnvironmentObject var navigationStack: NavigationStack
    
    var body: some View {
        NavigationStackView(navigationStack: NavigationStack()) {
            
            switch neighborsService.output {
            case .success(let neighbours):
                VStack{
                    Text("Neighbours of \(neighborsService.countryCode)" )
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 16)], alignment: .leading) {
                            if neighbours.count > 0 {
                                ForEach(neighbours) { neighbour in
                                    PushView(
                                        destination:
                                            HStack() {
                                                PopView {
                                                    Text("<")
                                                    NeighboursScreen(
                                                neighborsService: NeighbourCountriesService(
                                                    countryCode: neighbour.countryCode))
                                                }
                                            }) {
                                        
                                            CountryThumbnailView(country: Country(
                                                                    id: neighbour.countryCode,
                                                                    name: neighbour.countryName,
                                                                    imageURL: URL(string: "https://www.countryflags.io/\(neighbour.countryCode)/flat/64.png")))
                                        
                                        
                                    }
                                    
                                    //                                NavigationLink(destination: CountryScreen(model: CountryScreenModel(country: Country(
                                    //                                                                                                        id: neighbour.countryCode,
    //                                                                                                        name: neighbour.countryName,
    //                                                                                                        imageURL: URL(string: "https://www.countryflags.io/\(neighbour.countryCode)/flat/64.png"))), router: EnvironmentObject<Router>())
    //                                ) {
    //                                    CountryThumbnailView(country: Country(
    //                                                            id: neighbour.countryCode,
    //                                                            name: neighbour.countryName,
    //                                                            imageURL: URL(string: "https://www.countryflags.io/\(neighbour.countryCode)/flat/64.png")))
    //                                        .onTapGesture {
    //                                            <#code#>
    //                                        }
    //                                }
                                    
                                }
                            } else {
                                Text("No neighbouring countries")
                            }
                            
                        }
                    }
                }
                
            case .failure(let error):
                Text(error.localizedDescription)
            }
        }
    }
}

//struct NeighboursScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        NeighboursScreen()
//    }
//}
