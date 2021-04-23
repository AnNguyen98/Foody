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

struct User: Codable, DefaultsSerializable {
    var type: UserType = .customer
}
