//
//  RestaurantServices.swift
//  Foody
//
//  Created by MBA0283F on 5/18/21.
//

import Combine

struct ProductResponse: Decodable {
    var currentPage: Int
    var products: [Product]
    var nextPage: Bool
}

final class RestaurantServices {
    
    static func getProducts() -> AnyPublisher<ProductResponse, CommonError> {
        NetworkProvider.shared.request(.getProducts)
            .decode(type: ProductResponse.self)
            .eraseToAnyPublisher()
    }
    
    static func deleteProduct(id: String) -> AnyPublisher<Product, CommonError> {
        NetworkProvider.shared.request(.deleteProduct(id))
            .decode(type: Product.self)
            .eraseToAnyPublisher()
    }
    
    static func updateProduct(product: Product) -> AnyPublisher<Product, CommonError> {
        guard let params = try? product.toParameters() else {
            return Fail(error: .invalidInputData).eraseToAnyPublisher()
        }
        return NetworkProvider.shared.request(.updateProduct(params))
            .decode(type: Product.self)
            .eraseToAnyPublisher()
    }
    
    static func addNewProduct(product: Product) -> AnyPublisher<Product, CommonError> {
        guard let params = try? product.toParameters() else {
            return Fail(error: .invalidInputData).eraseToAnyPublisher()
        }
        return NetworkProvider.shared.request(.newProduct(params))
            .decode(type: Product.self)
            .eraseToAnyPublisher()
    }
    
    static func getOrders() -> AnyPublisher<[Order], CommonError> {
        NetworkProvider.shared.request(.getOrders)
            .decode(type: [Order].self)
            .eraseToAnyPublisher()
    }
    
    static func verifySendingOrder(id: String) -> AnyPublisher<Order, CommonError> {
        NetworkProvider.shared.request(.verifySending(id: id))
            .decode(type: Order.self)
            .eraseToAnyPublisher()
    }
    
    static func verifySendOrder(id: String) -> AnyPublisher<Order, CommonError> {
        NetworkProvider.shared.request(.verifySend(id: id))
            .decode(type: Order.self)
            .eraseToAnyPublisher()
    }
    
    struct ChartResponse: Decodable {
        var month: Int
        var data: [Int]
    }
    
    static func getChartsInfo(month: Int) -> AnyPublisher<ChartResponse, CommonError>  {
        NetworkProvider.shared.request(.getChartInfo(month))
            .decode(type: ChartResponse.self)
            .eraseToAnyPublisher()
    }
}
