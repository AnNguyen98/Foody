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

enum Router {
    case login(email: String, password: String)
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
        baseURLString = "http://0.0.0.0:5000" / version
        #endif
        guard let url = URL(string: baseURLString) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
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
        case .login:
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
        var headers = ["Content-type": "application/json"]
        if let token = Session.shared.accessTokens {
            headers["Authorization"] = token
        }
        return headers
    }
    
}



