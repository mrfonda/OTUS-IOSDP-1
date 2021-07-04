//
//  SearchBar.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 04/07/2021.
//

import Foundation

import SwiftUI
import UIKit
import Combine


struct SearchView: UIViewRepresentable {
    let controller = UISearchController()
    
    @ObservedObject var searchModel: CountriesService
    
    func makeUIView(context: UIViewRepresentableContext<SearchView>) -> UISearchBar {
        
        self.controller.searchBar.searchTextField.addTarget(searchModel, action: #selector(searchModel.textFieldDidChange), for: .editingChanged)

        return self.controller.searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchView>) {
//        uiView.text = searchModel.searchText
    }
    
    typealias UIViewType = UISearchBar


}
