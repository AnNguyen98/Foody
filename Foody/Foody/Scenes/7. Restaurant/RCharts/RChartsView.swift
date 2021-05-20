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
    
    var body: some View {
        VStack {
            LineView(
                data: [8,23,54,32],
                title: "Growth chart",
                legend: "July"
            )
            .padding()
            
            BarChartView(
                data: ChartData(values: [
                    ("2018 Q4", 100),
                    ("2018 Q4", 30),
                    ("2018 Q4", 80),
                    ("2018 Q4", 10),
            ]),
                title: "Sales",
                legend: "Quarterly",
                form: .init(width: kScreenSize.width - 30, height: 230)
            )
            
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
                        .frame(width: 40, height: 40)
                        .foregroundColor(viewModel.canNotPrevious ? Color.gray: Color.blue)
                })
                .disabled(viewModel.canNotPrevious)
                .padding(.horizontal, 25)
                
                Button(action: {
                    viewModel.getChartsInfo(month: viewModel.currentMonth + 1)
                }, label: {
                    Image(systemName: SFSymbols.arrowRightCircleFill)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(viewModel.canNotNext ? Color.gray: Color.blue)
                })
                .disabled(viewModel.canNotNext)
                .padding(.trailing, 30)
            }
            .padding()
        }
        .addLoadingIcon($viewModel.isLoading)
        .handleErrors($viewModel.error)
    }
}

struct RChartsView_Previews: PreviewProvider {
    static var previews: some View {
        RChartsView()
    }
}
