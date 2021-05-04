//
//  Notification.swift
//  Foody
//
//  Created by An Nguyễn on 01/05/2021.
//

import Foundation

struct Notification: Codable {
    var _id: String = UUID.init().uuidString
    
    var userId: String = ""
    
    var content: String = ""
    
    var time: String = ""
    
    var isRead: Bool = false
}
