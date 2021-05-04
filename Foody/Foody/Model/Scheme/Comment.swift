//
//  Comment.swift
//  Foody
//
//  Created by An Nguyễn on 01/05/2021.
//

import Foundation

struct Comment: Codable {
    var _id: String = UUID.init().uuidString
    
    var productId: String = ""
    
    var userId: String = ""
    
    var username: String = ""
    
    var imageProfileBase64: String = ""
    
    var content: String = ""
    
    var time: String
}

extension Comment {
    var imageProdile: Data? {
        Data(base64Encoded: imageProfileBase64)
    }
}
