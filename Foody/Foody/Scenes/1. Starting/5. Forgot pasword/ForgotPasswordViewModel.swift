//
//  ForgotPasswordViewModel.swift
//  Foody
//
//  Created by An Nguyễn on 4/5/21.
//

import SwiftUI

final class ForgotPasswordViewModel: ViewModel, ObservableObject {
    @Published var email: String = ""
}
