//
//  Order.swift
//  Foody
//
//  Created by An Nguyễn on 01/05/2021.
//

import Foundation

enum OrderStatus: String {
    case processing, shipping, payment
}

struct Order: Codable {
    var _id: String = UUID.init().uuidString
    
    var deliveryTime: String = ""
    
    var products: Product = Product()
    
    var count: Int = 0
    
    var status: String = OrderStatus.processing.rawValue
    
    var price: Int = 0
    
    var orderTime: String = Date().dateTimeString()
    
    var acceptedTime: String = Date().dateTimeString()
    
    var address: String = ""
    
    var phoneNumber: String = ""
    
}
