//
//  Account.swift
//  Foody
//
//  Created by An Nguyễn on 27/04/2021.
//

import Foundation

struct Account: Codable {
    var _id: String = UUID.init().uuidString
    
    var email: String = ""
    
    var username: String = ""
    
    var phoneNumber: String = ""
    
    var password: String = ""
    
    var status: String = AccountStatus.active.rawValue
}
