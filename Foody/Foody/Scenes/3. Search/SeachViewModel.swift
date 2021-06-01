//
//  SeachViewModel.swift
//  Foody
//
//  Created by An Nguyễn on 04/05/2021.
//

import SwiftUI
import SwifterSwift

final class SearchViewModel: ViewModel, ObservableObject {
    @Published var products: [Product] = []
    @Published var searchText: String = ""
    @Published var canLoadMore: Bool = false
    @Published var isLastRow: Bool = false
    var currentPage: Int = 0
    
    override init() {
        super.init()
        $searchText
            .dropFirst()
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .map({ $0.trimmingCharacters(in: .whitespacesAndNewlines) })
            .removeDuplicates()
            .print("DEBUG - SearchViewModel")
            .sink(receiveValue: { (text) in
                self.searchProducts(with: text)
            })
            .store(in: &subscriptions)
    }
    
    func detailsViewModel(_ product: Product) -> ProductDetailsViewModel {
        ProductDetailsViewModel(id: product._id)
    }
    
    func searchProducts(with text: String, page: Int = 0) {
        guard !searchText.isEmpty else {
            products.removeAll()
            return
        }
        isLoading = true
        CommonServices.searchProducts(productName: searchText, page: page)
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (res) in
                self.products = res.products
                self.currentPage = res.page
                self.canLoadMore = res.nextPage
            }
            .store(in: &subscriptions)
    }
    
    func handleLoadMore() {
        searchProducts(with: searchText, page: currentPage + 1)
    }
    
    func handleRefreshData() {
        products.removeAll()
        canLoadMore = false
        
        searchProducts(with: searchText)
    }
    
    func addToFavorite(_ product: Product) {
        guard let userId = Session.shared.user?._id else {
            error = .unknow("Can't get user id.")
            return
        }
        let item = FavoriteItemResponse(_id: UUID.init().uuidString, userId: userId, product: product)
        isLoading = true
        CustomerServices.addNewFavorie(item)
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (res) in
                Session.shared.favorites.append(res.product)
            }
            .store(in: &subscriptions)
    }
    
    func deleteInFavorite(_ product: Product) {
        isLoading = true
        CustomerServices.deleteFavorite(productId: product._id)
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (res) in
                Session.shared.favorites.removeAll(product)
            }
            .store(in: &subscriptions)
    }
}
