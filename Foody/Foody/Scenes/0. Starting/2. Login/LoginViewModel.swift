//
//  LoginViewModel.swift
//  Foody
//
//  Created by MBA0283F on 3/18/21.
//

import SwiftUI
import Combine
import Moya

final class LoginViewModel: ViewModel, ObservableObject{
    @Published var email: String = ""
    @Published var password: String = ""
    
    var subscriptions = Set<AnyCancellable>()
    
    func login() {
        isLoading = true
        HomeService().getPupularMovies()
            .sink(receiveCompletion: { completion in
                guard case let .failure(error) = completion else { return }
                self.isLoading = false
                print("AAAA", error)
            }, receiveValue: { response in
                print("AAAA", response)
                self.isLoading = false
            }).store(in: &subscriptions)
    }
}

extension LoginViewModel {
    
    var invalidInfo: Bool {
        !(email.isValidateEmail && password.isValidPasswordLength)
    }
}
