//
//  RandomCountryScreen.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 04/07/2021.
//

import SwiftUI
import UIComponents

struct RandomCountryScreen: View {
    @State private var isShowing = false
    @ObservedObject var viewModel: RandomCountryScreenViewModel
    
    var body: some View {
        
        Button {
            isShowing.toggle()
            if #available(iOS 15.0, *) {
                async {
                    await viewModel.fetchRandomCountry()
                }
            } else {
                // Fallback on earlier versions
            }
            
        } label: {
            Text("Show Random").font(.largeTitle)
        }.fullScreenCover(isPresented: $isShowing) {
            if let randomCountry = viewModel.randomCountry {
                Text("Random country:")
                CountryBubbleView(
                    id: randomCountry.id,
                    name: randomCountry.name,
                    imageURL: randomCountry.imageURL)
                    .onTapGesture {
                        isShowing.toggle()
                        viewModel.open()
                    }
            }
        }
    }
}
