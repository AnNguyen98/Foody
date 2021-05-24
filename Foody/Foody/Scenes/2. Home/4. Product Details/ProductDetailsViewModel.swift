//
//  ProductDetailsViewModel.swift
//  Foody
//
//  Created by An Nguyễn on 05/05/2021.
//

import SwiftUI

final class ProductDetailsViewModel: ViewModel, ObservableObject {
    private var productId: String
    
    @Published var product = Product()
    @Published var comments: [Comment] = []
    
    init(id: String = "") {
        self.productId = id
        super.init()
        getProductDetails()
    }
    
    func refreshData() {
        getProductDetails()
    }
    
    func getProductDetails() {
        isLoading = true
        CommonServices.getProduct(id: productId)
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (product) in
                self.product = product
            }
            .store(in: &subscriptions)
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
