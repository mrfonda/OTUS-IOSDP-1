//
//  CountryBubbleView.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 03/07/2021.
//
//#if !os(macOS)

import SwiftUI

public struct CountryBubbleView: View {
    @Environment(\.colorScheme) public var colorScheme

    public let id: String
    public let name: String
    public let imageURL: URL?
    
    public init(id: String, name: String, imageURL: URL?) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
    }
    
    public var body: some View {
        CountryThumbnailView(id: id, name: name, imageURL: imageURL)
            .padding()
            .background(Color.white)
            .foregroundColor(Color.black)
            .modifier(CardModifier())
    }
}

struct CountryBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        CountryBubbleView(
            id: "BE",
            name: "Belgium",
            imageURL: URL(string: "https://www.countryflags.io/be/flat/64.png")).preferredColorScheme(.dark)
    }
}

//#endif
