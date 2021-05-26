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
        images = product.productImages.compactMap({ UIImage(data: $0) })
        
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
        product.imageBase64Encodings = images.compactMap({ $0.pngBase64String() })
    }
    
    func updateProduct() {
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
