//
//  RegisterViewModel.swift
//  Foody
//
//  Created by MBA0283F on 3/15/21.
//

import Foundation
import SwifterSwift

final class RegisterViewModel: ObservableObject {
    @Published var type: UserType = .customer
    @Published var username: String = ""
    @Published var restaurantName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var verifyPassword: String = ""
    @Published var phoneNumber: String = ""
    @Published var emailNotExist: Bool = false
    
    
    func checkEmail() {
        emailNotExist = true
    }
}

extension RegisterViewModel {
    var verifyPhoneViewModel: VerifyPhoneViewModel {
        VerifyPhoneViewModel(for: .register)
    }
    
    var inValidInfo: Bool {
        username.isEmpty
    }
}
