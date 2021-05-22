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
    
    override init() {
        super.init()
        getProducts()
    }
    
    func detailsViewModel(with product: Product) -> ProductDetailsViewModel {
        ProductDetailsViewModel(id: product._id)
    }
    
    func getProducts(page: Int = 0) {
        guard !isLoading else { return }
        isLoading = true
        CustomerServices.getFavoriteProducts()
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (res) in
                self.currentPage = res.page
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
        CustomerServices.deleteFavorite(productId: id)
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
