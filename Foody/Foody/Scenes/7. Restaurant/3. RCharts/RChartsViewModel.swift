//
//  RChartsViewModel.swift
//  Foody
//
//  Created by MBA0283F on 5/19/21.
//

import Combine
import SwiftUI
import SwifterSwift

final class RChartsViewModel: ViewModel, ObservableObject {
    @Published var growthValuesData: [Int: [Double]] = [:]
    @Published var salesData: [Int: [(String, Double)]] = [:]
    @Published var currentMonth: Int = Date().month
    var monthDisplay: String {
        var date = Date()
        date.month = currentMonth
        return date.monthName()
    }
    
    var currentGrowthValues: [Double] {
        growthValuesData[currentMonth] ?? []
    }
    
    var currentSales: [(String, Double)] {
        salesData[currentMonth] ?? defaultSsales
    }
    
    var canNotNext: Bool  {
        Date().month == currentMonth
    }
    
    var canNotPrevious: Bool {
        Date().month - currentMonth == 5
    }
    
    override var tabIndex: Int? { 2 }
    
    override func setupData() {
        getChartsInfo(forceData: true)
    }
    
    func prepareData(_ charts: [ChartResponse], month: Int) {
        let currentCharts = charts.filter({ $0.month == currentMonth })
        var growths: [Double] = []
        var sales: [(String, Double)] = []
        for week in 1...4 {
            let temp = currentCharts.filter({ $0.orderDate.weekOfMonth == week })
            growths.append(temp.map({ $0.count }).reduce(0, +).double)
            let temp2 = temp.filter({ $0.status == OrderStatus.paymented })
            sales.append(("Week \(week)", temp2.map({ Double($0.price) }).reduce(0.0, +)))
        }
        growthValuesData[month] = growths
        salesData[month] = sales
    }
    
    func refreshData() {
        growthValuesData.removeAll()
        salesData.removeAll()
        
        getChartsInfo(isRefreshing: true)
    }
    
    func getChartsInfo(month: Int = Date().month, isRefreshing: Bool = false, forceData: Bool = false) {
        if !forceData, !isRefreshing, let _ = growthValuesData[month], let _ = salesData[month] {
            currentMonth = month
            return
        }
        isLoading = true
        RestaurantServices.getChartsInfo(month: month)
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (charts) in
                self.currentMonth = month
                self.prepareData(charts, month: month)
            }
            .store(in: &subscriptions)
    }
}

extension RChartsViewModel {
    var defaultSsales: [(String, Double)] {
        [("Week \(1)", 0), ("Week \(2)", 0), ("Week \(3)", 0), ("Week \(4)", 0)]
    }
}
