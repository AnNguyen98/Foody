//
//  Response.swift
//  Foody
//
//  Created by MBA0283F on 4/22/21.
//

import Moya

extension Response {
    var messageError: String {
        if let json = try? mapJSON() as? [String: Any], let message = json["message"] as? String {
            return message
        }
        return "Can't get message error."
    }
}
