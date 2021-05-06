//
//  FavoritesViewModel.swift
//  Foody
//
//  Created by An Nguyễn on 04/05/2021.
//

import Foundation

final class FavoritesViewModel: ViewModel, ObservableObject {
    @Published var products: [Product] = (0...20).map({ _ in Product() })
    @Published var canLoadMore: Bool = true
    @Published var isLastRow: Bool = false
    var currentPage: Int = 0
    
    func searchProducts(with text: String, page: Int = 0) {
        
    }
    
    func handleLoadMore() {
        
    }
    
    func handleRefreshData() {
        
    }
}
