//
//  CountryThumbnailView.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 03/07/2021.
//

import SwiftUI
import URLImage

struct CountryThumbnailView: View {
    var country: Country
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            if let url = country.imageURL {
                URLImage(url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32, alignment: .center)
                }
            }
            
            Text(country.name)
        }
    }
}
