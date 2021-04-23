//
//  StringExt.swift
//  Foody
//
//  Created by An Nguyễn on 4/5/21.
//

import Foundation

extension String {
    var isValidateEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self)
        return result
    }
    
    func isPasswordLength(password: String , confirmPassword : String) -> Bool {
        password.count <= 8 && confirmPassword.count <= 8
    }
    
    var isValidPasswordLength: Bool {
        count >= 8
    }

    /// Phone Number Validation
    var validatePhoneNumber: Bool {
        let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
    }
}

enum Process {
    case encode
    case decode
}

extension String {
    var len: Int { return count }
    var host: String? { return (try? asURL())?.host }

    func base64(_ method: Process) -> String {
        switch method {
        case .encode:
            guard let data = data(using: .utf8) else { return "" }
            return data.base64EncodedString()
        case .decode:
            guard let data = Data(base64Encoded: self),
                let string = String(data: data, encoding: .utf8) else { return "" }
            return string
        }
    }

    var trimmed: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

extension String {
    static func / (lhs: String, rhs: String) -> String {
        return lhs + "/" + rhs
    }
}
