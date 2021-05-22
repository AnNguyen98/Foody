//
//  RChartsViewModel.swift
//  Foody
//
//  Created by MBA0283F on 5/19/21.
//

import Combine
import SwiftUI
import SwifterSwift

struct ChartMonthData: Decodable {
    var time: String
    var orderCount: Int
}

final class RChartsViewModel: ViewModel, ObservableObject {
    private var charts: [Int: [Int]] = [:]
    var currentMonth: Int = Date().month
    
    @Published var currentChart: [Int] = []
    
    var canNotNext: Bool  {
        Date().month == currentMonth
    }
    
    var canNotPrevious: Bool {
        Date().month - currentMonth == 5
    }
    
    override init() {
        super.init()
        getChartsInfo()
    }
    
    func prepareData(_ charts: [ChartMonthData]) {
        
    }
    
    func getChartsInfo(month: Int = Date().month) {
        if let data = charts[month] {
            currentChart = data
            return
        }
        isLoading = true
        RestaurantServices.getChartsInfo(month: month)
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (response) in
                self.charts[month] = response.data
                self.currentChart = response.data
                self.currentMonth = month
            }
            .store(in: &subscriptions)
    }
}

