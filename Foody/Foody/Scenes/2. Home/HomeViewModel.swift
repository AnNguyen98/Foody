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
    
    func getProducts() {
        
    }
    
    func getRestaurants() {
        
    }
    
    func refreshData() {
        
    }
}
