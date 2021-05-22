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
    @Published var showSuccessPopup = false
    @Published var deleteSuccess = false
    
    var action: DetailsAction = .normal
    var product: Product = Product()
    var comments: [Comment] = []
    var images: [Data] {
        product.productImages
    }
    
    init(_ product: Product = Product()) {
        self.product._id = product._id
        super.init()
        if action == .normal {
            getProductInfo()
        }
    }
    
    func getProductInfo() {
        let group = DispatchGroup()
        
        isLoading = true
        
        group.enter()
        CommonServices.getProduct(id: product._id)
            .sink { (completion) in
                group.leave()
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (product) in
                self.product = product
            }
            .store(in: &subscriptions)

        group.enter()
        CommonServices.getComments(productId: product._id)
            .sink { (completion) in
                group.leave()
                if case .failure(let error) = completion {
                    //self.error = error
                }
            } receiveValue: { (comments) in
                self.comments = comments
            }
            .store(in: &subscriptions)
        
        group.notify(queue: .main) {
            self.isLoading = false
        }
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
        self.isLoading = true
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
