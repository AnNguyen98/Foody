//
//  FavoritesViewModel.swift
//  Foody
//
//  Created by An Nguyễn on 04/05/2021.
//

import Foundation

final class FavoritesViewModel: ViewModel, ObservableObject {
    @Published var products: [Product] = []
    @Published var isLastRow: Bool = false
    
    var currentPage: Int = 0
    var nextPage: Bool = true
    
    var canLoadMore: Bool  {
        isLastRow && nextPage
    }
    
    func detailsViewModel(with product: Product) -> ProductDetailsViewModel {
        ProductDetailsViewModel(id: product._id)
    }
    
    func getProducts(page: Int = 0) {
        isLoading = true
        ProductServices.getFavoriteProducts()
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (res) in
                self.currentPage = res.currentPage
                self.products = res.products
                self.nextPage = res.nextPage
            }
            .store(in: &subscriptions)
    }
    
    func handleLoadMore() {
        getProducts(page: currentPage + 1)
    }
    
    func handleRefreshData() {
        products.removeAll()
        nextPage = true
        currentPage = 0
        
        getProducts()
    }
    
    func deleteFavorite(id: String) {
        ProductServices.deleteFavorite(productId: id)
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (product) in
                self.products.removeAll(product)
            }
            .store(in: &subscriptions)
    }
}
