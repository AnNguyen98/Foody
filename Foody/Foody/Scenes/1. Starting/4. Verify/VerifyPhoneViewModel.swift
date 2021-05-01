//
//  VerifyPhoneViewModel.swift
//  Foody
//
//  Created by MBA0283F on 3/15/21.
//

import SwiftUI

final class VerifyPhoneViewModel: ViewModel, ObservableObject {
    private var userInfo = RegisterUserObject()
    private var verificationID: String = ""
    var action: Action
    @Published var showSuccessPopup: Bool = false
    @Published var code: String = "" {
        didSet {
            if /*Int(code) == nil || */ code.count > lengthLimit {
                code = oldValue
            }
            // Dismiss keyboard
            if code.count == lengthLimit {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
    
    init(for action: Action = .updatePassword("")) {
        if case .register(let user) = action {
            self.userInfo = user
        }
        self.action = action
        super.init()
        handleSendOTP()
    }
    
    func codeNumberOf(index: Int) -> String {
        values[safeIndex: index] ?? codeTextEmpty
    }
}

extension VerifyPhoneViewModel {
    private func handleUpdatePassword() {
        // MARK: TODO - handleUpdatePassword
    }
    
    private func handleRegister() {
        // MARK: TODO - handleRegister
        var user: User = User()
        user.gender = userInfo.gender
        user.username = userInfo.username
        user.email = userInfo.email
        user.phoneNumber = userInfo.phoneNumber
        user.address = userInfo.address
        user.type = UserType.restaurant.rawValue
//        userInfo.imageProfile = ""
        
        
        var restaurant: Restaurant?
        if userInfo.type == .restaurant {
            restaurant = Restaurant()
            restaurant?._id = user._id
            restaurant?.descriptions = userInfo.description
            restaurant?.name = userInfo.restaurantName
            restaurant?.address = userInfo.address
        }
        
        var account: Account = Account()
        account._id = user._id
        account.email = userInfo.email
        account.password = userInfo.password
        account.username = userInfo.username
        account.phoneNumber = userInfo.phoneNumber
        
        isLoading = true
        AccountService.register(for: user, with: account, restaurant: restaurant)
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (response) in
                if let _ = response.email, let _ = response.password {
                    self.showSuccessPopup =  true
                }
            }
            .store(in: &subscriptions)
    }
    
    func handleSendOTP() {
        FirebaseAuth.verifyPhoneNumber(phoneNumber: phoneNumber)
            .sink { (completion) in
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (verificationID) in
                self.verificationID = verificationID
            }
            .store(in: &subscriptions)
    }
    
    func handleVerifyOTP() {
        FirebaseAuth.signInAuth(verificationID: verificationID, code: code)
            .sink { (completion) in
                if case .failure(let error) = completion {
                    self.error = error
                } else {
                    self.handleAction()
                }
            } receiveValue: { (result) in
                print("DEBUG - VerifyPhoneViewModel: ", result)
            }
            .store(in: &subscriptions)

            
    }
    
    func handleAction() {
        if case .register = action {
            handleRegister()
        } else {
            handleUpdatePassword()
        }
    }
}

extension VerifyPhoneViewModel {
    enum Action {
        case register(RegisterUserObject), updatePassword(String)
    }
    
    var lengthLimit: Int { 6 }
    
    var values: [String] {
        Array(code)
            .map({ String($0) })
    }
    
    var isValid: Bool {
        code.count >= lengthLimit
    }
    
    var codeTextEmpty: String {
        "∙"
    }
    
    var phoneNumber: String {
        if case .updatePassword(let phone) = action {
            return phone
        }
        return userInfo.phoneNumber
    }
    
    var messageNoti: String {
        if case .register = action {
            return "Congratulations your account has been successfully created."
        }
        return "Successful password reset."
    }
    
    var title: String {
        "Continue"
    }
}



