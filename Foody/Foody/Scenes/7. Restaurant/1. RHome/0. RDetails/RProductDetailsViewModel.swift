//
//  RDetailsViewModel.swift
//  Foody
//
//  Created by MBA0283F on 5/20/21.
//

import Combine
import SwiftUI

enum DetailsAction {
    case preview, normal
}

final class RProductDetailsViewModel: ViewModel, ObservableObject {
    @Published var product: Product
    @Published var comments: [Comment] = []
    @Published var showSuccessPopup = false
    @Published var deleteSuccess = false
    
    var action: DetailsAction = .normal
    var images: [Data] {
        product.productImages
    }
    
    init(_ product: Product = Product()) {
        self.product = product
        super.init()
        if action == .normal {
            getProductInfo()
        }
    }
    
    func getProductInfo() {
        isLoading = true
        CommonServices.getProduct(id: product._id)
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
    
    func getComments() {
        isLoading = true
        CommonServices.getComments(productId: product._id)
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (comments) in
                self.comments = comments
            }
            .store(in: &subscriptions)
    }
    
    func requestNewProduct() {
        self.isLoading = true
        RestaurantServices.addNewProduct(product: product)
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (product) in
                self.showSuccessPopup = true
            }
            .store(in: &subscriptions)

    }
    
    func deleteProduct() {
        RestaurantServices.deleteProduct(id: product._id)
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (product) in
                self.deleteSuccess = true
            }
            .store(in: &subscriptions)
    }
}
