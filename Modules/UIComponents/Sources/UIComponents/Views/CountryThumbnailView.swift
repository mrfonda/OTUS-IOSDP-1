//
//  CountryThumbnailView.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 03/07/2021.
//
#if !os(macOS)

import SwiftUI
import URLImage

public struct CountryThumbnailView: View {
    public let id: String
    public let name: String
    public let imageURL: URL?
    
    public init(id: String, name: String, imageURL: URL?) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: 16) {
            if let url = imageURL {
                URLImage(url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32, alignment: .center)
                }
            }
            
            Text(name)
        }
    }
}


#endif
