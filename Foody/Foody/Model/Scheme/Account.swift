//
//  Account.swift
//  Foody
//
//  Created by An Nguyễn on 27/04/2021.
//

import Foundation

protocol Account {
    var username: String { get set }
    
    var email: String { get set }
    
    var password: String { get set }
    
    var phoneNumber: String { get set }
    
    var address: String { set get }
    
    var gender: Bool { set get }
    
    var isActive: Bool { set get }
}
