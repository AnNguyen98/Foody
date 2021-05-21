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
    @State var isDrinkSelected = false
    @Published var images: [UIImage] = []
    
    var type: String {
        isDrinkSelected ? "drink": "food"
    }
    
    var inValidInfo: Bool {
        price.isEmpty && productName.isEmpty && description.isEmpty && images.isEmpty
    }
    
    var product: Product {
        let restaurantId: String  = Session.shared.user?._id ?? ""
        let restaurantName: String  = Session.shared.user?.username ?? ""
        let price = Int(self.price) ?? 0
        let imageEncodings = images.compactMap({ $0.pngBase64String() })
        
        return Product(restaurantId: restaurantId,
                       restaurantName: restaurantName,
                       imageBase64Encodings: imageEncodings,
                       name: productName, price: price,
                       descriptions: description, type: type
        )
    }
    
    var previewDetailViewModel: RProductDetailsViewModel {
        RProductDetailsViewModel(product)
    }
}
