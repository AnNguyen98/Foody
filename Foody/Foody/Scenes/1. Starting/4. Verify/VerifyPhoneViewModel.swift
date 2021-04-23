//
//  VerifyPhoneViewModel.swift
//  Foody
//
//  Created by MBA0283F on 3/15/21.
//

import SwiftUI

final class VerifyPhoneViewModel: ObservableObject {
    private var lengthLimit: Int = 6
    var values: [Character] { Array(code) }
    var isValid: Bool { code.count >= lengthLimit }
    
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
}



