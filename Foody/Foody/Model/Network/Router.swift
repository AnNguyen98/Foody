//
//  ApiManager.swift
//  Foody
//
//  Created by MBA0283F on 4/5/21.
//

import Moya

typealias Parameters = [String: Any]
typealias JSObject = [String: Any]
typealias JSArray = [JSObject]

enum VerifyAction: String {
    case register, forgot
}

enum Router {
    case updatePassword(email: String, password: String)
    case verifyEmail(email: String, action: VerifyAction)
    case login(email: String, password: String)
    case register(Parameters)
    case details(id: String)
    case trending
////     First import Alamofire to make use of ‘Parameters’
//    case endPointWithLotsOfParams(parameters: Parameters)
}

extension Router: TargetType {
    var version: String {
        return "v1"
    }
    
    var baseURL: URL {
        var baseURLString: String = "https://flask-fast-food.herokuapp.com" / version
        #if DEBUG
        baseURLString = "http://127.0.0.1:5000" / version
        #endif
        guard let url = URL(string: baseURLString) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .updatePassword:
            return "/account/password/forgot"
        case .verifyEmail:
            return "/account/verify/email"
        case .register:
            return "/register"
        case .login:
            return "/login"
        case .details(let id):
            return ""
        case .trending:
            return ""
//        case .endPointWithLotsOfParams(parameters: let parameters):
//            return "/videos"
        }
    }
    
    var method: Method {
        switch self {
        case .login, .register, .verifyEmail, .updatePassword:
            return .post
        case .details, .trending:
            return .get
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .updatePassword(let email, let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        case .verifyEmail(let email, let action):
            return .requestParameters(parameters: ["email": email, "action": action.rawValue], encoding: JSONEncoding.default)
        case .register(let params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .login(let email, let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        case .details(let id):
            return .requestParameters(parameters: ["id": id], encoding: URLEncoding.queryString)
        case .trending: //, .newMovies(let page):
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
//        case .endPointWithLotsOfParams(parameters: let parameters):
//            return .requestParameters(parameters:  parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
//        {
//            "email": "theannguyen98@gmail.com",
//            "accessToken": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InRoZWFubmd1eWVuOThAZ21haWwuY29tIiwiZXhwIjo1MjIwMTE2MDY2fQ.REe2ueW0q0vow1yQfTmbtAx0yHMGY5O9pRvncVi5alQ"
//        }
        var headers = ["Content-type": "application/json"]
        if let token = Session.shared.accessToken {
            headers["Authorization"] = token
        }
        return headers
    }
    
}



