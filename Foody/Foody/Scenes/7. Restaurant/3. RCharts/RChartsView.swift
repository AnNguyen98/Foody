//
//  RChartView.swift
//  Foody
//
//  Created by MBA0283F on 5/19/21.
//

import SwiftUI
import SwiftUICharts

struct RChartsView: View {
    @StateObject private var viewModel = RChartsViewModel()
    
    func barChartView() -> some View {
        BarChartView(
            data: ChartData(values: viewModel.currentSales),
            title: "Sales for \(viewModel.monthDisplay)",
            legend: "Quarterly",
            form: .init(width: kScreenSize.width - 30, height: 230),
            animatedToBack: true
        )
        .padding(.vertical)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LineView(
                    data: viewModel.currentGrowthValues,
                    title: "Growth chart",
                    legend: viewModel.monthDisplay
                )
                .padding()
                .frame(height: 400)
                
                // Fix no render animation
                if viewModel.currentMonth.isOdd {
                    barChartView()
                } else {
                    barChartView()
                }
            }
            .padding(.top, Constants.MARGIN_TOP_STATUS_BAR)
            
            Divider()
            
            HStack {
                Text("See other months")
                    .font(.title3)
                    .bold()
                    .padding(.trailing)
                
                Spacer()
                
                Button(action: {
                    viewModel.getChartsInfo(month: viewModel.currentMonth - 1)
                }, label: {
                    Image(systemName: SFSymbols.arrowLeftCircleFill)
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor(viewModel.canNotPrevious ? Color.gray: Color.blue)
                })
                .disabled(viewModel.canNotPrevious)
                .padding(.horizontal, 25)
                
                Button(action: {
                    viewModel.getChartsInfo(month: viewModel.currentMonth + 1)
                }, label: {
                    Image(systemName: SFSymbols.arrowRightCircleFill)
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor(viewModel.canNotNext ? Color.gray: Color.blue)
                })
                .disabled(viewModel.canNotNext)
                .padding(.trailing, 30)
            }
            .padding(.horizontal)
        }
        .onRefresh {
            viewModel.getChartsInfo(isRefreshing: true)
        }
        .addLoadingIcon($viewModel.isLoading)
        .handleErrors($viewModel.error)
        .navigationBarHidden(true)
        .statusBar(hidden: true)
//        .statusBarStyle(.darkContent)
    }
}

struct RChartsView_Previews: PreviewProvider {
    static var previews: some View {
        RChartsView()
    }
}
