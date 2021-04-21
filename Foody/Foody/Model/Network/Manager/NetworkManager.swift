
//
//  NetworkManager.swift
//  Foody
//
//  Created by MBA0283F on 3/23/21.
//

import Moya
import Combine
import Foundation


struct NetworkManager {
    static var shared: NetworkManager = NetworkManager()
    
    private var provider = MoyaProvider<FoodApi>(plugins: [NetworkLoggerPlugin()])
    private init() { }
    
    func request(_ api: FoodApi) -> AnyPublisher<Any, MoyaError> {
        return Future<Any, MoyaError> { promise in
            self.provider.request(api) { (result) in
                switch result {
                case .success(let response):
                    promise(.success(response.data))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
