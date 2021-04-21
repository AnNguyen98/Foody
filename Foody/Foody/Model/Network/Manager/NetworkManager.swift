
//
//  NetworkManager.swift
//  Foody
//
//  Created by MBA0283F on 3/23/21.
//

import Moya
import Combine
import Foundation

extension MoyaError {
    
}

struct NetworkManager {
    static var shared: NetworkManager = NetworkManager()
    
    private var provider = MoyaProvider<FoodApi>(plugins: [NetworkLoggerPlugin()])
    private init() { }
    
    func request(_ api: FoodApi) -> AnyPublisher<Any, RequestError> {
        return Future<Any, RequestError> { promise in
            self.provider.request(api) { (result) in
                switch result {
                case .success(let response):
                    if 400...499 ~= response.statusCode {
                        promise(.failure(.unknow(response.messageError)))
                    }
                    promise(.success(response.data))
                case .failure(let error):
                    promise(.failure(.unknow(error.errorDescription ?? "")))
                }
            }
        }.eraseToAnyPublisher()
    }
}

extension Response {
    var messageError: String {
        if let json = try? mapJSON() as? [String: Any], let message = json["message"] as? String {
            return message
        }
        return "Can't get message error."
    }
}
