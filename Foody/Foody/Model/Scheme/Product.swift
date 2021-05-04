//
//  Product.swift
//  Foody
//
//  Created by An Nguyễn on 30/04/2021.
//

import Foundation

enum ProductType: String {
    case drink, food
}

enum ProductStatus: String {
    case accepted, none
}

struct Product: Codable {
    var _id: String = UUID.init().uuidString
    
    var restaurantId: String = ""
    
    var imageBase64Encodings: [String] = []
    
    var voteCount: Int = 0
    
    var name: String = ""
    
    var price: Int = 0
    
    var descriptions: String = ""
        
    var type: String = ProductType.food.rawValue
    
    var orderCount: Int = 0
    
    var status: String = ProductStatus.none.rawValue
}

extension Product {
    var productImages: [Data?] {
        imageBase64Encodings.map({ Data(base64Encoded: $0) })
    }
}
