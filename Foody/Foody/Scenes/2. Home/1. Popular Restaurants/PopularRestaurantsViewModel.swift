//
//  PopularRestaurantsViewModel.swift
//  Foody
//
//  Created by An Nguyễn on 05/05/2021.
//

import SwiftUI

final class PopularRestaurantsViewModel: ViewModel, ObservableObject {
    @Published var restaurants: [Restaurant] = (0...20).map({ _ in Restaurant() })
    @Published var canLoadMore: Bool = true
    @Published var isLastRow: Bool = false
    
    func getPopularRestaurants() {
        
    }
    
    func handleLoadMore() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.restaurants += (0...20).map({ _ in Restaurant() })
            self.isLastRow = false
        }
    }
    
    func handleRefreshData() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.restaurants = (0...20).map({ _ in Restaurant() })
            self.isLoading = false
        }
    }
}
