//
//  ProductDetailsViewModel.swift
//  Foody
//
//  Created by An Nguyễn on 05/05/2021.
//

import SwiftUI

final class ProductDetailsViewModel: ViewModel, ObservableObject {
    var productId: String
    
    init(id: String = "") {
        self.productId = id
    }
}
