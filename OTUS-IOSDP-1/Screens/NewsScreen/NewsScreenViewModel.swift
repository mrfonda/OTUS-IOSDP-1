//
//  NewsScreenViewModel.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 23/07/2021.
//

import Foundation
import Networking

final class NewsScreenViewModel: ObservableObject {
    private let queryString: String
    private var noMoreResilts: Bool = false
    private var date: String {
        Calendar.current.date(
            byAdding: Calendar.Component.month,
            value: -1,
            to: Date()).map({ date -> String in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                return dateFormatter.string(from: date)
            }) ?? ""
    }
    
    private let queue: DispatchQueue = .init(label: "\(NewsScreenViewModel.self)")
    
    var page: Int = 1
    
    @Published private(set) var items: [Article] = .init()
    @Published private(set) var isLoading: Bool = false
    
    init (queryString: String) {
        self.queryString = queryString
        load()
    }
    
    func load() {
        guard !isLoading, !noMoreResilts else { return }
        
        isLoading = true
        
        Networking.ArticlesAPI
            .everythingGet(
                q: queryString,
                from: date,
                sortBy: "publishedAt",
                language: "en",
                apiKey: AppSettings.shared.newsAPIKey,
                page: page,
                apiResponseQueue: queue) { [weak self] (articleList, error)  in
                
                guard
                    let self = self
                else {
                    return
                }
                
                if let error = error {
                    print(
                        """
                        🆕❌ Failed loading news for: \(self.queryString), page: \( self.page)
                        🆕\(error)
                        """
                    )
                } else {
                    print("🆕✅ Loaded news for: \(self.queryString), page: \( self.page)")
                }
                
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                
                guard
                    let articleList = articleList,
                    let articles = articleList.articles
                else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.items += articles
                }
                
                if let totalResults = articleList.totalResults,
                   totalResults > articles.count {
                    print("🆕 total results: \(totalResults), fetched: \(self.items.count)")
                } else {
                    print("🆕 No more results, fetched: \(self.items.count)")
                    self.noMoreResilts = true
                }
            }
    }
    
    func reload() {
        page = 1
        noMoreResilts = false
        items = []
        load()
    }
    
    func loadMore(currentItem item: Article) {
        if items.isLast(item) {
            page += 1
            load()
        }
    }
}
