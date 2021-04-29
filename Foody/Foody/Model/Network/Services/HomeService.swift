//
//  HomeService.swift
//  Foody
//
//  Created by MBA0283F on 4/8/21.
//

import Combine
import Moya

final class HomeService {
    
    struct TrendingResponse: Decodable {
        var results: [Movie] = []
        var totalPages: Int = 0
        var totalResults: Int = 0
        var page: Int = 0
        
        enum TrendingResponseCodingKeys: String, CodingKey {
            case page, results
            case totalPages = "total_pages"
            case totalResults = "total_results"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: TrendingResponseCodingKeys.self)
            
            self.page = try container.decode(Int.self, forKey: .page)
            self.totalResults = try container.decode(Int.self, forKey: .totalResults)
            self.totalPages = try container.decode(Int.self, forKey: .totalPages)
            self.results = try container.decode(Array<Movie>.self, forKey: .results)
        }
    }
        
    func getPupularMovies() -> AnyPublisher<TrendingResponse, CommonError> {
        NetworkProvider.shared.request(.trending)
            .decode(type: TrendingResponse.self)
            .eraseToAnyPublisher()
    }
}
