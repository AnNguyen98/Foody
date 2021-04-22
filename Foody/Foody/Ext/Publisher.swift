//
//  Publisher.swift
//  Foody
//
//  Created by MBA0283F on 4/22/21.
//

import Combine
import Foundation

extension Publisher where Output == Data {
    func decode<T: Decodable>(type: T.Type) -> AnyPublisher<T, NetworkError> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        return self.decode(type: type, decoder: decoder)
            .mapError { error in
                .unknow(error.localizedDescription)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        }
}
