//
//  LoginService.swift
//  Foody
//
//  Created by An Nguyễn on 21/04/2021.
//

import Combine
import Foundation
import FirebaseAuth

final class AccountService {
    struct AccountResponse: Decodable {
        var email: String
        var token: String
    }
    
    class func login(email: String, password: String) -> AnyPublisher<AccountResponse, NetworkError>  {
        NetworkProvider.shared.request(.login(email: email, password: password))
            .decode(type: AccountResponse.self)
            .eraseToAnyPublisher()
    }
    
    class func logout() {
        try? Auth.auth().signOut()
    }
}
