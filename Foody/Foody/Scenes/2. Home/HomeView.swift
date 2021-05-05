//
//  HomeView.swift
//  Foody
//
//  Created by MBA0283F on 3/4/21.
//

import SwiftUI
import SwifterSwift

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
        
    var body: some View {
        ScrollView {
            Section(header: headerView("Trending products",  destination: TrendingProductsView().toAnyView)) {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 15) {
                        ForEach(0..<10) { item in
                            NavigationLink(destination: FoodDetailsView(), label: {
                                ProductCellView()
                                    .frame(width: 250 * scale)
                            })
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            Section(header: headerView("Most popular", destination: PopularRestaurantsView().toAnyView)) {
                LazyVStack(spacing: 15) {
                    ForEach(0..<10) { item in
                        NavigationLink(destination: RestaurantDetailsView(), label: {
                            RestaurantCellView()
                        })
                    }
                }
                .padding([.horizontal, .bottom])
            }
        }
        .onRefresh {
            refreshData()
        }
        .background(.white)
        .setupBackgroundNavigationBar()
        .navigationBarItems(
            trailing: NotificationsView()
        )
        .navigationBarTitle("Home", displayMode: .automatic)
        .setupNavigationBar()
        .statusBarStyle(.lightContent)
        .handleHidenKeyboard()
        .handleErrors($viewModel.error)
        .addLoadingIcon($viewModel.isLoading)
        .onAppear {
            setupData()
        }
    }
}

extension HomeView {
    func headerView(_ title: String, destination: AnyView) -> some View {
        HStack {
            Text(title)
                .bold()
                .multilineTextAlignment(.leading)
                .font(.title3)
            
            Spacer()
            
            NavigationLink(
                destination: destination,
                label: {
                    Text("See more")
                        .underline()
                        .font(.body)
                })
        }
        .foregroundColor(.black)
        .padding([.horizontal, .top])
        .padding(.bottom, 5)
    }

}

extension HomeView {
    func setupData() {
        
    }
    
    func refreshData() {
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}
