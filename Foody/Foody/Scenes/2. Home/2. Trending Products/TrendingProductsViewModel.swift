//
//  PopularRestaurantsViewModel.swift
//  Foody
//
//  Created by An Nguyễn on 05/05/2021.
//

import SwiftUI

final class TrendingProductsViewModel: ViewModel, ObservableObject {
    @Published var products: [Product] = (0...20).map({ _ in Product() })
    @Published var canLoadMore: Bool = true
    @Published var isLastRow: Bool = false
    
    func getPopularRestaurants() {
        
    }
    
    func handleLoadMore() {
        guard !isLoading else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.products += (0...20).map({ _ in Product() })
            self.isLastRow = false
        }
    }
    
    func handleRefreshData() {
        guard !isLoading else { return }
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.products = (0...20).map({ _ in Product() })
            self.isLoading = false
        }
    }
}
