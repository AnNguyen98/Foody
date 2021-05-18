//
//  CustomerServices.swift
//  Foody
//
//  Created by MBA0283F on 5/18/21.
//

import Combine

final class CustomerServices {

    static func cancelOrder(id: String, reason: String = "") -> AnyPublisher<Order, CommonError> {
        NetworkProvider.shared.request(.cancelOrder(id))
            .decode(type: Order.self)
            .eraseToAnyPublisher()
    }
    
    static func popularRestaurants() -> AnyPublisher<[Restaurant], CommonError> {
        NetworkProvider.shared.request(.popularRestaurants)
            .decode(type: [Restaurant].self)
            .eraseToAnyPublisher()
    }
    
    static func trendingProducts() -> AnyPublisher<[Product], CommonError> {
        NetworkProvider.shared.request(.trendingProducts)
            .decode(type: [Product].self)
            .eraseToAnyPublisher()
    }
    
    static func voteRestaurant(id: String,  voteCount: Int) -> AnyPublisher<Restaurant, CommonError> {
        NetworkProvider.shared.request(.voteRestaurant(id, voteCount))
            .decode(type: Restaurant.self)
            .eraseToAnyPublisher()
    }
    
    static func voteProduct(id: String,  voteCount: Int) -> AnyPublisher<Product, CommonError> {
        NetworkProvider.shared.request(.voteProduct(id, voteCount))
            .decode(type: Product.self)
            .eraseToAnyPublisher()
    }
    
    static func comment(id: String,  comment: Comment) -> AnyPublisher<Comment, CommonError> {
        guard let params = try? comment.toParameters() else {
            return Fail(error: CommonError.invalidInputData).eraseToAnyPublisher()
        }
        return NetworkProvider.shared.request(.comment(id, params))
            .decode(type: Comment.self)
            .eraseToAnyPublisher()
    }
}

// Favorites
extension CustomerServices {
    
    static func getFavoriteProducts() -> AnyPublisher<ProductResponse, CommonError> {
        NetworkProvider.shared.request(.getFavorites)
            .decode(type: ProductResponse.self)
            .eraseToAnyPublisher()
    }
    
    static func deleteFavorite(productId: String) -> AnyPublisher<Product, CommonError> {
        NetworkProvider.shared.request(.deleteFavorite(productId))
            .decode(type: Product.self)
            .eraseToAnyPublisher()
    }
    
    static func addNewFavorie(_ product: Product) -> AnyPublisher<Product, CommonError> {
        guard let params = try? product.toParameters() else {
            return Fail(error: CommonError.invalidInputData).eraseToAnyPublisher()
        }
        return NetworkProvider.shared.request(.newFavorite(params))
            .decode(type: Product.self)
            .eraseToAnyPublisher()
    }
}
