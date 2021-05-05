//
//  PopularRestaurantsView.swift
//  Foody
//
//  Created by An Nguyễn on 05/05/2021.
//

import SwiftUI
import SwiftUIX

struct PopularRestaurantsView: View {
    @StateObject private var viewModel = PopularRestaurantsViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 15) {
                ForEach(viewModel.restaurants, id: \._id) { restaurant in
                    RestaurantCellView()
                        .onAppear(perform: {
                            if restaurant == viewModel.restaurants.last {
                                viewModel.isLastRow = true
                            }
                        })
                        .onDisappear(perform: {
                            print("DEBUG - onDisappear")
                        })
                }
                
                if viewModel.canLoadMore, viewModel.isLastRow {
                    ActivityIndicator()
                        .style(.regular)
                        .tintColor(.black)
                        .onAppear {
                            handleLoadMore()
                        }
                        .padding(.bottom, 8)
                }
            }
            .padding()
        }
        .onRefresh {
            handleRefresh()
        }
        .background(.white)
        .setupBackgroundNavigationBar()
        .navigationBarTitle("Popular", displayMode: .automatic)
        .setupNavigationBar()
        .statusBarStyle(.lightContent)
        .handleErrors($viewModel.error)
        .addLoadingIcon($viewModel.isLoading)
        .onAppear {
            viewModel.getPopularRestaurants()
        }
    }
}

extension PopularRestaurantsView {
    private func handleRefresh() {
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (_) in
            viewModel.handleRefreshData()
        }
    }
    
    private func handleLoadMore() {
        viewModel.handleLoadMore()
    }
}

struct PopularRestaurantsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PopularRestaurantsView()
        }
    }
}
