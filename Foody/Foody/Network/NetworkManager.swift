
//
//  NetworkManager.swift
//  Foody
//
//  Created by MBA0283F on 3/23/21.
//

import Moya

protocol Networkable {
    associatedtype T: TargetType
    var provider: MoyaProvider<T> { get }
}

//struct NetworkManager: Networkable {
//    static let MovieAPIKey = "myKey"
//    let provider = MoyaProvider<FoodApi>(plugins: [NetworkLoggerPlugin(ver: true)])
//
//    func getNewMovies(page: Int, completion: @escaping ([Movie]) -> ()) {
//        provider.request(.newMovies(page: page)) { result in
//            switch result {
//            case let .success(response):
//                do {
//                    let results = try JSONDecoder().decode(MovieResults.self, from: response.data)
//                    completion(results.movies)
//                } catch let err {
//                    print(err)
//                }
//            case let .failure(error):
//                print(error)
//            }
//        }
//    }
//}
