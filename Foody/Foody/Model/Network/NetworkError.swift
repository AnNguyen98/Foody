//
//  ResponseError.swift
//  Foody
//
//  Created by MBA0283F on 4/8/21.
//

import Moya

enum NetworkError: Error, Identifiable {
    case invalidData
    case invalidJSONFormat
    case authen
    case apiKey
    case network
    case cancelRequest
    case emptyData
    case noResponse
    case invalidURL
    case invalidAreaCode
    case timeout
    case unknow(String)
    
    var id: String { UUID().uuidString }
    
    var description: String {
        switch self {
        case .timeout:
            return "Request timeout."
        case .apiKey:
            return ""
        case .invalidURL:
            return "Cannot detect URL."
        case .authen:
            return "Unauthorized."
        case .noResponse:
            return "No response."
        case .emptyData:
            return "Empty data."
        case .cancelRequest:
            return "Server returns no information and closes the connection."
        case .network:
            return "The internet connection appears to be offline."
        case .invalidJSONFormat:
            return "Invalid JSON Format"
        case .invalidData:
            return "Invalid Data Format."
        case .unknow(let description):
            return description
        case .invalidAreaCode:
            return "Invalid area code."
        }
    }
    
    
}
