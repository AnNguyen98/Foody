//
//  User.swift
//  Foody
//
//  Created by An Nguyễn on 4/13/21.
//

import Foundation
import SwiftyUserDefaults

enum UserType: Int, Codable {
    case customer, restaurant
}

class User: Account, Codable, DefaultsSerializable {
    var username: String
    
    var email: String
    
    var password: String
    
    var phoneNumber: String
    
    var address: String
    
    var imageProfile: Data
    
    init(username: String, email: String, password: String, phoneNumber: String, address: String, imageProfile: Data) {
        self.username = username
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.address = address
        self.imageProfile = imageProfile
    }
}
