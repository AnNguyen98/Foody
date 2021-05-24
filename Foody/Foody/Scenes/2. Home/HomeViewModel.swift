//
//  HomeViewModel.swift
//  Foody
//
//  Created by An Nguyễn on 04/05/2021.
//

import SwiftUI

final class HomeViewModel: ViewModel, ObservableObject {
    var trendingProducts: [Product] = []
    var popularRestaurants: [Restaurant] = []
    
    override init() {
        super.init()
        getHomeData()
    }
    
    func getHomeData() {
        isLoading = true
        CustomerServices.popularRestaurants()
            .zip(CustomerServices.trendingProducts(), CustomerServices.getFavoriteProducts())
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (res1, res2, res3) in
                self.popularRestaurants = res1.restaurants
                self.trendingProducts = res2.products
                Session.shared.favorites = res3.map({ $0.product })
            }
            .store(in: &subscriptions)
    }
    
    func refreshData() {
        trendingProducts.removeAll()
        popularRestaurants.removeAll()
        
        getHomeData()
    }
}
