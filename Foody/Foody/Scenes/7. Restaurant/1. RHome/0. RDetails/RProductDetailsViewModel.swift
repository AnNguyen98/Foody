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
    
    var previewViewModel: RAddProductViewModel {
        RAddProductViewModel(product)
    }
    
    init(_ product: Product = Product(), action: DetailsAction = .normal) {
        self.action = action
        self.product = product
        print("DEBUG - product.localImages", product.localImages?.count ?? 0)
        super.init()
        if action == .normal {
            getProductInfo()
        }
    }
    
    func getProductInfo() {
        isLoading = true
        CommonServices.getProduct(id: product._id)
            .zip(CommonServices.getComments(productId: product._id))
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (product, comments) in
                self.product = product
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

extension RProductDetailsViewModel {
    func handleAddNewProduct() {
        let dataImages = product.localImages ?? []
        var images: [(Data, String)] = []
        for index in 0..<dataImages.count {
            let uuid = UUID.init().uuidString + ".png"
            images.append((dataImages[index], uuid))
        }
        isLoading = true
        FirebaseTask.uploadImages(images: images)
            .sink { (completion) in
                self.isLoading = false
                if case .failure = completion {
                    self.error = .unknown("Failure for upload image.")
                }
            } receiveValue: { (urls) in
                self.product.imageBase64Encodings = urls.compactMap({ $0.absoluteString })
                print("DEBUG - Uploaded: \(urls)")
                self.requestNewProduct()
            }
            .store(in: &subscriptions)
    }
}
