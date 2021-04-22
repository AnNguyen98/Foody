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
    
    class func login(email: String, password: String) -> AnyPublisher<UserResponse, NetworkError>  {
        NetworkProvider.shared.request(.login(email: email, password: password))
            .decode(type: UserResponse.self)
            .eraseToAnyPublisher()
    }
}
