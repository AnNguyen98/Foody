//
//  ResponseError.swift
//  Foody
//
//  Created by MBA0283F on 4/8/21.
//

import Moya

class ResponseError {
    static let invalidData = NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "Invalid Data Format"])
    static let invalidJSONFormat = NSError(domain: "", code: 600, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON Format"])
    static let network = NSError(domain: "", code: 600, userInfo: [NSLocalizedDescriptionKey: "The internet connection appears to be offline."])
    static let authen = NSError(domain: "", code: 300, userInfo: [NSLocalizedDescriptionKey: "Unauthorized"])
    static let apiKey = NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: ""])
    static let cancelRequest = NSError(domain: "", code: 999, userInfo: [NSLocalizedDescriptionKey: "Server returns no information and closes the connection."])
    static let emptyData = NSError(domain: "", code: 997, userInfo: [NSLocalizedDescriptionKey: "Empty data."])
    static let noResponse = NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "No response."])
    static let invalidURL = NSError(domain: "", code: 998, userInfo: [NSLocalizedDescriptionKey: "Cannot detect URL."])
}
