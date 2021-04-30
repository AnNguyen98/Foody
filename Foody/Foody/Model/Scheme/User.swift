//
//  User.swift
//  Foody
//
//  Created by An Nguyễn on 4/13/21.
//

import Foundation
import SwiftyUserDefaults

enum UserType: String, Codable {
    case customer, restaurant
    
    var isCustomer: Bool {
        self == .customer
    }
    
    var isRestaurant: Bool {
        self == .restaurant
    }
}

class User: Codable, Account, DefaultsSerializable {
    var isActive: Bool = false
    
    var username: String = ""
    
    var email: String = ""
    
    var password: String = ""
    
    var phoneNumber: String = ""
    
    var address: String = ""
    
    var imageProfile: String = ""
    
    var gender: Bool = false
}
