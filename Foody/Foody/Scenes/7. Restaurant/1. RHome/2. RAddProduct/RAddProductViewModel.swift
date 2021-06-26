//
//  RAddProductViewModel.swift
//  Foody
//
//  Created by MBA0283F on 5/19/21.
//

import Combine
import SwiftUI
import SwifterSwift

final class RAddProductViewModel: ViewModel, ObservableObject {
    @Published var price: String = ""
    @Published var productName: String = ""
    @Published var description: String = ""
    @Published var isDrinkSelected = false
    @Published var images: [UIImage] = []
    @Published var isPresentedSuccessPopup = false
    
    var type: String {
        isDrinkSelected ? "drink": "food"
    }
    
    var inValidInfo: Bool {
        price.isEmpty && productName.isEmpty && description.isEmpty && images.isEmpty
    }
    
    var product: Product = Product()
    
    var previewDetailViewModel: RProductDetailsViewModel {
        RProductDetailsViewModel(product, action: .preview)
    }
    
    var isEditProduct: Bool = false
    
    init(_ product: Product = Product()) {
        super.init()
        
        self.product = product
        
        price = String(product.price)
        productName = product.name
        description = product.descriptions
        productName = product.name
        isDrinkSelected = product.isDrink
        
        DispatchQueue.global().async {
            let imgs = product.imageUrls.compactMap({ URL(string: $0) })
                .compactMap({ try? UIImage(url: $0) })
            DispatchQueue.main.async {
                self.images = imgs
            }
        }
        
        isEditProduct = product.name != ""
    }
    
    func prepareProduct() {
        product.restaurantId = Session.shared.user?._id ?? ""
        product.restaurantName  = Session.shared.restaurant?.name ?? ""
        product.phoneNumber = Session.shared.user?.phoneNumber ?? ""
        product.name  = productName
        product.descriptions = description
        product.type = type
        product.price = Int(self.price) ?? 0
    }
    
    func handleUpdateProduct() {
        let dataImages = images.compactMap({ $0.pngData() })
        let lastPathComponents = product.imageBase64Encodings.compactMap({ $0.url?.lastPathComponent })
        var images: [(Data, String)] = []
        for index in 0..<dataImages.count {
            images.append((dataImages[index], lastPathComponents[safeIndex: index] ?? ""))
        }
        
        FirebaseTask.uploadImages(images: [])
            .sink { (completion) in
                if case .failure(let error) = completion {
                    self.isLoading = false
                    self.error = error
                }
            } receiveValue: { (urls) in
                self.product.imageBase64Encodings = urls.compactMap({ $0.absoluteString })
                self.updateProduct()
            }
            .store(in: &subscriptions)
    }
    
    private func updateProduct() {
        prepareProduct()
        
        isLoading = true
        RestaurantServices.updateProduct(product: product)
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (product) in
                self.isPresentedSuccessPopup = true
            }
            .store(in: &subscriptions)
    }
}
