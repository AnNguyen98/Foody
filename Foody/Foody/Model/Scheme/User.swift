//
//  User.swift
//  Foody
//
//  Created by An Nguyễn on 4/13/21.
//

import Foundation

enum UserType {
    case customer, restaurant
}

class User {
    var type: UserType = .customer
}
