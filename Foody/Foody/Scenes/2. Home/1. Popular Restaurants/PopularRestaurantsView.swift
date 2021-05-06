//
//  PopularRestaurantsView.swift
//  Foody
//
//  Created by An Nguyễn on 05/05/2021.
//

import SwiftUI

struct PopularRestaurantsView: View {
    @StateObject private var viewModel = PopularRestaurantsViewModel()
    
    var body: some View {
        LazyVStack(spacing: 15) {
            ForEach(viewModel.restaurants, id: \._id) { restaurant in
                RestaurantCellView()
                    .onAppear(perform: {
                        if restaurant == viewModel.restaurants.last {
                            viewModel.isLastRow = true
                        }
                    })
            }
        }
        .padding(.bottom)
        .prepareForLoadMore(loadMore: {
            handleLoadMore()
        }, showIndicator: viewModel.canLoadMore && viewModel.isLastRow)
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
