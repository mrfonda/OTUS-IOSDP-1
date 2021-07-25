//
//  CountryBubbleView.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 03/07/2021.
//

import SwiftUI

struct CountryBubbleView: View {
    @Environment(\.colorScheme) var colorScheme

    var country: Country
    
    var body: some View {
        CountryThumbnailView(country: country)
            .padding()
            .background(Color.white)
            .foregroundColor(Color.black)
            .modifier(CardModifier())
    }
}

struct CountryBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        CountryBubbleView(country: Country(
                            id: "BE",
                            name: "Belgium",
                            imageURL: URL(string: "https://www.countryflags.io/be/flat/64.png"))).preferredColorScheme(.dark)
    }
}
