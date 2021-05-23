//
//  FavoritesViewModel.swift
//  Foody
//
//  Created by An Nguyễn on 04/05/2021.
//

import Foundation

final class FavoritesViewModel: ViewModel, ObservableObject {
    @Published var products: [FavoriteItemResponse] = []
    @Published var isLastRow: Bool = false
    var currentPage: Int = 0
    var nextPage: Bool = false
    
    var canLoadMore: Bool  {
        isLastRow && nextPage
    }
    
    override init() {
        super.init()
        getFavoriteProducts()
    }
    
    func detailsViewModel(_ product: Product) -> ProductDetailsViewModel {
        ProductDetailsViewModel(id: product._id)
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
                self.products = items
                Session.shared.favorites = items.map({ $0.product })
            }
            .store(in: &subscriptions)
    }
    
    func handleLoadMore() {
        getFavoriteProducts(page: currentPage + 1)
    }
    
    func handleRefreshData() {
        products.removeAll()
        nextPage = false
        currentPage = 0
        
        getFavoriteProducts()
    }
    
    func deleteFavorite(id: String) {
        CustomerServices.deleteFavorite(productId: id)
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (item) in
                self.products.removeAll(where: { $0.product == item?.product })
            }
            .store(in: &subscriptions)
    }
}
