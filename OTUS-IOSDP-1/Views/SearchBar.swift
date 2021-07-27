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
    @Binding var searchText: String
    
    final class Coordinator: NSObject, UISearchControllerDelegate {
        var searchText: Binding<String>
        
        var controller : UISearchController
        
        init(searchController: UISearchController, searchText: Binding<String>) {
            self.searchText = searchText
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
        
        @objc func textFieldDidChange(_ tf: UITextField) {
            searchText.wrappedValue = tf.text ?? ""
        }
    }

    
    func makeCoordinator() -> Coordinator {
        let controller = UISearchController()
        let coordinator = Coordinator(searchController: controller, searchText: $searchText)
        controller.delegate = coordinator
        return coordinator
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchView>) -> UISearchBar {

        context.coordinator.controller.searchBar.searchTextField.addTarget(context.coordinator, action: #selector(Coordinator.textFieldDidChange), for: .editingChanged)
        
        return context.coordinator.controller.searchBar
    }


    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchView>) {
        if uiView.text == nil || uiView.text?.isEmpty == true {
            context.coordinator.resign()
        }
    }
    
    typealias UIViewType = UISearchBar


}
