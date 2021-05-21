
//
//  NetworkManager.swift
//  Foody
//
//  Created by MBA0283F on 3/23/21.
//

import Moya
import Combine
import Foundation

struct NetworkProvider {
    static var shared: NetworkProvider = NetworkProvider()
    
    private var provider = MoyaProvider<Router>(plugins: [NetworkLoggerPlugin()])
    private init() { }
    
    func request(_ api: Router) -> AnyPublisher<Data, CommonError> {
        return Future<Data, CommonError> { promise in
            self.provider.request(api) { (result) in
                switch result {
                case .success(let response):
                    if 400...499 ~= response.statusCode {
                        promise(.failure(.unknow(response.messageError)))
                    } else {
                        promise(.success(response.data))
                    }
                case .failure(let error):
                    promise(.failure(.unknow(error.errorDescription ?? "")))
                }
            }
        }
        .print("DEBUG - NetworkProvider")
        .timeout(.seconds(Constants.TIMEOUT), scheduler: DispatchQueue.global(), customError: { .timeout })
        .retry(Constants.RETRYTIME)
        .subscribe(on: DispatchQueue.global())
        .eraseToAnyPublisher()
    }
}
