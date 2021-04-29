//
//  Restaurant.swift
//  Foody
//
//  Created by An Nguyễn on 29/04/2021.
//

import Foundation

final class Restaurant: User {
    var restaurantName: String
    var description: String
    
    init(username: String, email: String, password: String, phoneNumber: String, address: String,
         imageProfile: Data, restaurantName: String, description: String) {
        self.restaurantName = restaurantName
        self.description = description
        super.init(username: username, email: email, password: password, phoneNumber: phoneNumber,
                   address: address, imageProfile: imageProfile)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
