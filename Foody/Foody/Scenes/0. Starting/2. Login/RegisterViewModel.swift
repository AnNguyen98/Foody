//
//  RegisterViewModel.swift
//  Foody
//
//  Created by MBA0283F on 3/15/21.
//

import Foundation

enum UserType {
    case normal, restaurant
}

final class RegisterViewModel: ObservableObject {
    @Published var type: UserType = .normal
    @Published var username: String = ""
    @Published var restaurantName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var verifyPassword: String = ""
    @Published var phoneNumber: String = "+84"
}
