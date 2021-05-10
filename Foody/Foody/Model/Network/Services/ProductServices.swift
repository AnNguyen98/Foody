//
//  ProductServices.swift
//  Foody
//
//  Created by MBA0283F on 5/10/21.
//

import Combine

final class ProductServices {
    struct FavoriteResponse: Decodable {
        var currentPage: Int
        var products: [Product]
        var nextPage: Bool
    }
    
    static func getFavoriteProducts() -> AnyPublisher<FavoriteResponse, CommonError> {
        NetworkProvider.shared.request(.getFavorites)
            .decode(type: FavoriteResponse.self)
            .eraseToAnyPublisher()
    }
    
    static func deleteFavorite(productId: String) -> AnyPublisher<Product, CommonError> {
        NetworkProvider.shared.request(.deleteFavorite(id: productId))
            .decode(type: Product.self)
            .eraseToAnyPublisher()
    }
    
    static func addNewFavorie(_ product: Product) -> AnyPublisher<Product, CommonError> {
        guard let params = try? product.toParameters() else {
            return Fail(error: CommonError.invalidInputData).eraseToAnyPublisher()
        }
        return NetworkProvider.shared.request(.newFavorite(params: params))
            .decode(type: Product.self)
            .eraseToAnyPublisher()
    }
}
