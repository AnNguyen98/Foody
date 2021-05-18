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
    
    //Customer
    case cancelOrder(String)
    case popularRestaurants, trendingProducts
    case getRestaurant(String)
    case comment(String, Parameters)
    case voteRestaurant(String, Int)
    case voteProduct(String, Int)
    
    // Common
    case getProduct(String)
    case getOrders
    case getNotifications, readNotification(id: String) // SWIP
    
    // Restaurant
    case getProducts, newProduct(Parameters), deleteProduct(String), updateProduct(Parameters)
    case searchProducts(productName: String)
    case getChartInfo
    case verifySending(id: String)
    case verifySend(id: String)
    
    case getFavorites, newFavorite(Parameters), deleteFavorite(String)
    case updatePassword(String, String)
    case verifyEmail(email: String, VerifyAction)
    case login(String, String)
    case register(Parameters)
    case trending
}

extension Router: TargetType {
    var version: String {
        return "v1"
    }
    
    var baseURL: URL {
        let baseURLString: String = "https://flask-fast-food.herokuapp.com" / version
//        #if DEBUG
//        baseURLString = "http://127.0.0.1:5000" / version
//        #endif
        guard let url = URL(string: baseURLString) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .voteProduct:
            return "/product/vote"
        case .voteRestaurant:
            return "/restaurant/vote"
        case .comment:
            return "/product/comment"
        case .getRestaurant:
            return "/restaurant"
        case .cancelOrder:
            return "/order/cancel"
        case .trendingProducts:
            return "/products/trending"
        case .popularRestaurants:
            return "/restaurants/popular"
            
        case .getFavorites, .deleteFavorite, .newFavorite:
            return "/products/favorite"
        case .updatePassword:
            return "/account/password/forgot"
        case .verifyEmail:
            return "/account/verify/email"
        case .register:
            return "/register"
        case .login:
            return "/login"
        case .trending:
            return ""
            
        case .getProducts:
            return "/products"
        case .getProduct, .newProduct, .deleteProduct, .updateProduct:
            return "/product"
            
        case .searchProducts:
            return "search/products"
            
        case .getChartInfo:
            return "/charts"
        
        case .getOrders:
            return "/orders"
        case .verifySending, .verifySend:
            return "/order/verify"
            
        case .getNotifications:
            return "/notifications"
        case .readNotification:
            return "/notification"
        }
    }
    
    var method: Method {
        switch self {
        case .login, .register, .verifyEmail, .newFavorite, .newProduct, .comment, .voteProduct, .voteRestaurant:
            return .post
        case .updateProduct, .updatePassword, .verifySending, .verifySend, .readNotification:
            return .put
        case .deleteFavorite, .deleteProduct, .cancelOrder:
            return .delete
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .voteProduct(let id, let vote), .voteRestaurant(let id, let vote):
            return .requestParameters(parameters: ["id": id, "voteCount": vote], encoding: JSONEncoding.default)
        case .newFavorite(let params), .newProduct(let params), .updateProduct(let params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        
        case .comment(let id, let params):
            var tempParams = params
            tempParams["productId"] = id
            return .requestParameters(parameters: tempParams, encoding: JSONEncoding.default)
        
        case .deleteFavorite(let id), .deleteProduct(let id), .verifySending(let id), .verifySend(let id),
             .readNotification(let id), .cancelOrder(let id), .getRestaurant(let id):
            return .requestParameters(parameters: ["id": id], encoding: JSONEncoding.default)
        
        case .getProduct(let id):
            return .requestParameters(parameters: ["id": id], encoding: URLEncoding.queryString)
        case .searchProducts(let productName):
            return .requestParameters(parameters: ["productName": productName], encoding: URLEncoding.queryString)
            
        case .updatePassword(let email, let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        case .verifyEmail(let email, let action):
            return .requestParameters(parameters: ["email": email, "action": action.rawValue], encoding: JSONEncoding.default)
        case .register(let params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .login(let email, let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
            
        case .trending, .popularRestaurants, .trendingProducts, .getFavorites,
             .getProducts, .getChartInfo, .getOrders, .getNotifications: //, .newMovies(let page):
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
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
        headers["Authorization"] = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InRoZWFubmd1eWVuOThAZ21haWwuY29tIiwiZXhwIjo1MjIwMTE2MDY2fQ.REe2ueW0q0vow1yQfTmbtAx0yHMGY5O9pRvncVi5alQ"
        return headers
    }
    
}



