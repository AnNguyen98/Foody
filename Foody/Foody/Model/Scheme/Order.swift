//
//  Order.swift
//  Foody
//
//  Created by An Nguyễn on 01/05/2021.
//

import Foundation

enum OrderStatus: String {
    case processing, shipping, paymented, canceled
}

struct Order: Codable {
    var _id: String = UUID.init().uuidString
    
    var userId: String = ""
    
    var products: Product = Product()
    
    var count: Int = 0
    
    var status: String = OrderStatus.processing.rawValue
    
    var price: Int = 0
    
    var orderTime: String = Date().dateTimeString()
    
    var acceptedTime: String = ""
    
    var deliveryTime: String = ""
    
    var address: String = ""
    
    var phoneNumber: String = ""
    
}

extension Order: Hashable {
    static func ==(lhs: Order, rhs: Order?) -> Bool {
            return lhs._id == rhs?._id
        }

    func hash(into hasher: inout Hasher) {
        hasher.combine(_id)
    }
}
