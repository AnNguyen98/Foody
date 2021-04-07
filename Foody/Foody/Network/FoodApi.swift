//
//  ApiManager.swift
//  Foody
//
//  Created by MBA0283F on 4/5/21.
//

import Moya

typealias Parameters = [String: Any]

enum FoodApi {
    case recommended(id:Int)
    case popular(page:Int)
    case newMovies(page:Int)
    case video(id:Int)
    // First import Alamofire to make use of ‘Parameters’
    case endPointWithLotsOfParams(parameters: Parameters)
}

//extension FoodApi: TargetType {
//    var baseURL: URL {
//        guard let url = URL(string: "https://api.themoviedb.org/3/movie/") else {
//            fatalError("baseURL could not be configured.")
//        }
//        return url
//    }
//    
//    var path: String {
//        switch self {
//        case .recommended(let id):
//            return "\(id)/recommendations"
//        case .popular:
//            return "popular"
//        case .newMovies:
//            return "now_playing"
//        case .video(let id):
//            return "\(id)/videos"
//        case .endPointWithLotsOfParams(parameters: let parameters):
//            return "/videos"
//        }
//    }
//    
//    var method: Method {
//        .get
//    }
//    
//    var sampleData: Data {
//        Data()
//    }
//    
//    var task: Task {
//        switch self {
//        case .recommended, .video:
//            return .requestParameters(parameters: ["api_key": NetworkManager.MovieAPIKey], encoding: URLEncoding.queryString)
//        case .popular(let page), .newMovies(let page):
//            return .requestParameters(parameters: ["page": page, "api_key": NetworkManager.MovieAPIKey], encoding: URLEncoding.queryString)
//        case .endPointWithLotsOfParams(parameters: let parameters):
//            return .requestParameters(parameters:  parameters, encoding: URLEncoding.queryString)
//        }
//    }
//    
//    var headers: [String : String]? {
//        return ["Content-type": "application/json"]
//    }
//    
//}



