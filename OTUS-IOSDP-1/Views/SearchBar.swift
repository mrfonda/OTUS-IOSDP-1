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

    final class Coordinator: NSObject, UISearchControllerDelegate {
        var controller : UISearchController
        
        init(searchController: UISearchController) {
            controller = searchController
            super.init()
        }
        
        func resign() {
            controller.resignFirstResponder()
            
            controller.searchBar.resignFirstResponder()
            controller.isActive = false
            controller.showsSearchResultsController = false
            controller.searchBar.text = nil
            controller.searchBar.showsCancelButton = false

            controller.searchBar.endEditing(true)
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            resign()
        }
    }

    
    func makeCoordinator() -> Coordinator {
        let controller = UISearchController()
        let coordinator = Coordinator(searchController: controller)
        controller.delegate = coordinator
        return coordinator
    }
    
    @ObservedObject var searchModel: CountriesService
    
    func makeUIView(context: UIViewRepresentableContext<SearchView>) -> UISearchBar {

        context.coordinator.controller.searchBar.searchTextField.addTarget(searchModel, action: #selector(searchModel.textFieldDidChange), for: .editingChanged)

        return context.coordinator.controller.searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchView>) {
        if uiView.text == nil || uiView.text?.isEmpty == true {
            context.coordinator.resign()
        }
    }
    
    typealias UIViewType = UISearchBar


}
