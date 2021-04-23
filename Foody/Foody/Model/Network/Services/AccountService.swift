//
//  LoginService.swift
//  Foody
//
//  Created by An Nguyễn on 21/04/2021.
//

import Combine
import Foundation
import FirebaseAuth

protocol AccountFetchable {
    static func login(email: String, password: String) -> AnyPublisher<AccountService.AccountResponse, NetworkError>
}

final class AccountService: AccountFetchable {
    struct AccountResponse: Decodable {
        var email: String
        var token: String
    }
    
    static func login(email: String, password: String) -> AnyPublisher<AccountResponse, NetworkError>  {
        NetworkProvider.shared.request(.login(email: email, password: password))
            .decode(type: AccountResponse.self)
            .eraseToAnyPublisher()
    }
    
    static func logout() {
        try? Auth.auth().signOut()
    }
}
