//
//  HomeViewModel.swift
//  Foody
//
//  Created by An Nguyễn on 04/05/2021.
//

import SwiftUI

final class HomeViewModel: ViewModel, ObservableObject {
    @Published var trendingProducts: [Product] = []
    @Published var popularRestaurants: [Restaurant] = []
    
    override init() {
        super.init()
        
        getFavoriteProducts()
    }
    
    func getProducts() {
        
    }
    
    func getRestaurants() {
        
    }
    
    func refreshData() {
        
    }
    
    func getFavoriteProducts(page: Int = 0) {
        guard !isLoading else { return }
        isLoading = true
        CustomerServices.getFavoriteProducts()
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (items) in
                Session.shared.favorites = items.map({ $0.product })
            }
            .store(in: &subscriptions)
    }
}
