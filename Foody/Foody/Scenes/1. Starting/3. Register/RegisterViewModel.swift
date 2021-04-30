//
//  RegisterViewModel.swift
//  Foody
//
//  Created by MBA0283F on 3/15/21.
//

import SwiftUI
import SwifterSwift
import Combine
import PhoneNumberKit

final class RegisterUserObject: ObservableObject {
    var type: UserType = .customer
    var gender: Bool = false
    @Published var username: String = ""
    @Published var description: String = ""
    @Published var restaurantName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var verifyPassword: String = ""
    @Published var phoneNumber: String = ""
}

final class RegisterViewModel: ViewModel, ObservableObject {
    @Published var userInfo = RegisterUserObject()
    @Published var emailNotExist: Bool = false
    @Published var isRestaurant: Bool = false {
        didSet {
            userInfo.type = isRestaurant ? .restaurant: .customer
        }
    }
    @Published var isMale: Bool = true {
        didSet {
            userInfo.gender = isMale
        }
    }
    
    func checkEmail() {
        AccountService.verifyEmail(email: userInfo.email)
            .sink { (completion) in
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (res) in
                self.emailNotExist = res.isValid ?? false
            }
            .store(in: &subscriptions)
    }
}

extension RegisterViewModel {
    //MARK: - TODO Formater phone number display!
    var phoneNumber: String {
        return PartialFormatter().formatPartial("+84\(userInfo.phoneNumber.removingPrefix("+84"))")
    }
    
    var verifyPhoneViewModel: VerifyPhoneViewModel {
        VerifyPhoneViewModel(for: .register(userInfo))
    }
    
    var inValidInfo: Bool {
        userInfo.username.isEmpty || (userInfo.restaurantName.isEmpty && userInfo.type.isRestaurant)
            || !userInfo.email.isValidateEmail || !("+" + userInfo.phoneNumber).validatePhoneNumber
            || userInfo.password != userInfo.verifyPassword || !userInfo.password.isValidPasswordLength
            || !userInfo.verifyPassword.isValidPasswordLength
    }
}
