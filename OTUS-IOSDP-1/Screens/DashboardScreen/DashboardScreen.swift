//
//  DashboardScreen.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 03/07/2021.
//

import SwiftUI
import UIComponents

struct DashboardScreen: View {
    @EnvironmentObject var viewModel: DashboardScreenViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            
            Text("Information about countries")
                .font(Font.headline)
            
            if let lastCountry = viewModel.router.lastCountry {
                
                VStack(alignment: .center, spacing: 16) {
                    Text("Last seen country:")
                    CountryBubbleView(
                        id: lastCountry.id,
                        name: lastCountry.name,
                        imageURL: lastCountry.imageURL)
                        .onTapGesture {                            withAnimation {
                                viewModel.openLast()
                            }
                        }
                }
            }
            
            if let randomCountry = viewModel.randomCountry {
                VStack(alignment: .center, spacing: 16) {
                    Text("Random country:")
                    CountryBubbleView(
                        id: randomCountry.id,
                        name: randomCountry.name,
                        imageURL: randomCountry.imageURL)
                        .onTapGesture {
                            withAnimation {
                                viewModel.openRandom()
                            }
                        }
                }
            }
        }
        .onAppear() {
            viewModel.fetchRandomCountry()
        }
    }
}

struct DashboardScreen_Previews: PreviewProvider {
    static var previews: some View {
        DashboardScreen()
    }
}
