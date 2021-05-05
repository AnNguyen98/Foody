//
//  Restaurant.swift
//  Foody
//
//  Created by An Nguyễn on 01/05/2021.
//

import Foundation
import SwiftyUserDefaults

struct Restaurant: Codable, DefaultsSerializable {
    var _id: String = UUID.init().uuidString
    
    var descriptions: String = ""
    
    var address: String = ""
    
    var images: [String] = []
    
    var name: String = ""
        
    var vote: Int = 0
    
    var openTime: String = ""
    
    var closeTime: String = ""
}
