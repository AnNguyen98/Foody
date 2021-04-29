//
//  Firebase.Auth.swift
//  Foody
//
//  Created by MBA0283F on 4/8/21.
//

import FirebaseAuth
import Combine
import Moya

struct FirebaseAuth {
    static func verifyPhoneNumber(phoneNumber: String) -> AnyPublisher<String, CommonError> {
        guard phoneNumber.hasPrefix("+84") else {
            return Fail(error: CommonError.invalidAreaCode).eraseToAnyPublisher()
        }
        print("DEBUG - FirebaseAuth verifyPhoneNumber: \(phoneNumber)")
        return Future<String, CommonError> { promise in
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
                if let error = error {
                    print("DEBUG - FirebaseAuth verifyPhoneNumber: ", error.localizedDescription)
                    promise(.failure(.unknow(error.localizedDescription)))
                } else {
                    if let verificationID = verificationID {
                        promise(.success(verificationID))
                    } else {
                        promise(.failure(.unknow("Verification ID is empty.")))
                    }
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    static func signInAuth(verificationID: String, code: String) -> AnyPublisher<Any, CommonError> {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: code)
        print("DEBUG - FirebaseAuth signInAuth verificationID: \(verificationID) - code: \(code)")
        return Future<Any, CommonError> { promise in
            Auth.auth().signIn(with: credential) { (result, error) in
                if let error = error {
                    print("DEBUG - FirebaseAuth signIn: ", error.localizedDescription)
                    promise(.failure(.unknow(error.localizedDescription)))
                } else {
                    promise(.success(result ?? ""))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
