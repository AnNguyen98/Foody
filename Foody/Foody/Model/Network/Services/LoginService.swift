//
//  LoginService.swift
//  Foody
//
//  Created by An Nguyễn on 21/04/2021.
//

import Combine
import Foundation

final class LoginService {
    struct UserResponse: Decodable {
        var email: String
        var token: String
    }
    
    class func login(email: String, password: String) -> AnyPublisher<UserResponse, Error>  {
        NetworkManager.shared.request(.login(email: email, password: password))
            .tryMap({
                guard let data = $0 as? Data else {
                    throw ResponseError.invalidData
                }
                return data
            })
            .decode(type: UserResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
