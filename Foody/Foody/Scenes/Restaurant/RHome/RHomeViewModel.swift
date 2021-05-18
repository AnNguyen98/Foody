//
//  RHomeViewModel.swift
//  Foody
//
//  Created by MBA0283F on 5/18/21.
//

import SwiftUI

final class RHomeViewModel: ViewModel, ObservableObject {
    @Published var products: [Product] = (0...20).map({ _ in Product() })
    @Published var searchText: String = ""
    @Published var canLoadMore: Bool = true
    @Published var isLastRow: Bool = false
    var currentPage: Int = 0
    
    func getProducts() {
        
    }
    
    func refreshData() {
        
    }
    
    func handleLoadMore() {
        
    }
}

