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
typealias DataCompletion = () -> Void
//typealias Completion = (Moya.Response<Any>) -> Void

enum FoodApi {
    case details(id: String)
    
//    case recommended(id:Int)
    case trending
//    case newMovies(page:Int)
//    case video(id:Int)
////     First import Alamofire to make use of ‘Parameters’
//    case endPointWithLotsOfParams(parameters: Parameters)
}

extension FoodApi: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/Week?api_key=5e027139c66f977f5356baedc345f04f") else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .details(let id):
            return ""
//        case .recommended(let id):
//            return "\(id)/recommendations"
        case .trending:
            return ""
//        case .newMovies:
//            return "now_playing"
//        case .video(let id):
//            return "\(id)/videos"
//        case .endPointWithLotsOfParams(parameters: let parameters):
//            return "/videos"
        }
    }
    
    var method: Method {
        switch self {
        case .details, .trending:
            return .get
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .details(let id):
            return .requestParameters(parameters: ["id": id], encoding: URLEncoding.queryString)
//        case .recommended, .video:
//            return .requestParameters(parameters: ["api_key": NetworkManager.MovieAPIKey], encoding: URLEncoding.queryString)
        case .trending: //, .newMovies(let page):
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
//        case .endPointWithLotsOfParams(parameters: let parameters):
//            return .requestParameters(parameters:  parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}



