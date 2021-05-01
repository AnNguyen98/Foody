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
    static func login(email: String, password: String) -> AnyPublisher<AccountService.AccountResponse, CommonError>
    static func register(for user: User, with account: Account, restaurant: Restaurant?) -> AnyPublisher<AccountService.AccountResponse, CommonError>
    static func verifyEmail(email: String, action: VerifyAction) -> AnyPublisher<AccountService.AccountResponse, CommonError>
}

final class AccountService: AccountFetchable {
    struct AccountResponse: Decodable {
        var email: String?
        var password: String?
        var phoneNumber: String?
        var token: String?
        var isValid: Bool?
    }
    
    static func verifyEmail(email: String, action: VerifyAction) -> AnyPublisher<AccountResponse, CommonError> {
        return NetworkProvider.shared.request(.verifyEmail(email: email, action: action))
            .decode(type: AccountResponse.self)
            .eraseToAnyPublisher()
    }
    
    static func register(for user: User, with account: Account, restaurant: Restaurant? = nil) -> AnyPublisher<AccountResponse, CommonError>  {
        var params: Parameters = [:]
        if let userJS = try? user.toParameters(), let accountJS = try? account.toParameters() {
            params["user"] = userJS
            params["account"] = accountJS
            if restaurant != nil {
                guard let resJS = try? restaurant?.toParameters() else {
                    return Fail(error: .invalidInputData).eraseToAnyPublisher()
                }
                params["restaurant"] = resJS
            }
        } else {
            return Fail(error: .invalidInputData).eraseToAnyPublisher()
        }
        return NetworkProvider.shared.request(.register(params))
            .decode(type: AccountResponse.self)
            .eraseToAnyPublisher()
    }
    
    static func login(email: String, password: String) -> AnyPublisher<AccountResponse, CommonError>  {
        NetworkProvider.shared.request(.login(email: email, password: password))
            .decode(type: AccountResponse.self)
            .eraseToAnyPublisher()
    }
    
    static func logout() {
        try? Auth.auth().signOut()
    }
}
