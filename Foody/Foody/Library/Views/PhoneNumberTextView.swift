//
//  PhoneNumberTextView.swift
//  Foody
//
//  Created by An Nguyễn on 30/04/2021.
//

import SwiftUI
import PhoneNumberKit

struct PhoneNumberTextView: UIViewRepresentable {
 
    @Binding var phoneNumber: String
 
    func makeUIView(context: Context) -> PhoneNumberTextField {
        let textField = PhoneNumberTextField()
        textField.textColor = .white
        textField.delegate = context.coordinator
        let phoneImageView = UIImageView(image: UIImage(systemName: "phone.fill"))
        phoneImageView.tintColor = .white
        textField.leftView = phoneImageView
        textField.withFlag = true
        textField.leftViewMode = .always
        textField.maxDigits = 9
        textField.withPrefix = true
        textField.placeholder = PartialFormatter().formatPartial("+84399879847")
        textField.numberPlaceholderColor = .gray
        return textField
    }
 
    func updateUIView(_ uiView: PhoneNumberTextField, context: Context) {
        uiView.text = phoneNumber
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
     
    class Coordinator: NSObject, UITextFieldDelegate {
        var phoneNumberTextView: PhoneNumberTextView
     
        init(_ phoneNumberTextView: PhoneNumberTextView) {
            self.phoneNumberTextView = phoneNumberTextView
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            self.phoneNumberTextView.phoneNumber = textField.text ?? ""
            print("DEBUG - PhoneNumberTextView", textField.text ?? "")
        }
    }
}
