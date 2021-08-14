//
//  NewsScreen.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 23/07/2021.
//

import SwiftUI
import Networking

extension Article: Identifiable {
    public var id: String {
        return url.stringValue
    }
}

struct NewsScreen: View {
    @ObservedObject var model: NewsScreenViewModel
    
    var body: some View {
        List(model.items) { article in
            Text(article.title ?? "")
                .onAppear() {
                    model.loadMore(currentItem: article)
                }
        }
    }
}
