//
//  Notification.swift
//  Foody
//
//  Created by An Nguyễn on 01/05/2021.
//

import Foundation

struct Notifications: Codable {
    var _id: String = UUID.init().uuidString
    
    var userId: String = ""
    
    var content: String = ""
    
    var time: String = ""
    
    var isRead: Bool = false
}

extension Notifications: Hashable {
    static func ==(lhs: Notifications, rhs: Notifications?) -> Bool {
            return lhs._id == rhs?._id
        }

    func hash(into hasher: inout Hasher) {
        hasher.combine(_id)
    }
}
