//
//  PopularRestaurantsView.swift
//  Foody
//
//  Created by An Nguyễn on 05/05/2021.
//

import SwiftUI

struct PopularRestaurantsView: View {
    @StateObject private var viewModel = PopularRestaurantsViewModel()
    @State private var isActiveDetails = false
    
    var body: some View {
        LazyVStack(spacing: 15) {
            ForEach(viewModel.restaurants, id: \._id) { restaurant in
                ZStack {
                    NavigationLink(destination: RestaurantDetailsView(viewModel: viewModel.detailsViewModel(restaurant)),
                                   isActive: $isActiveDetails, label: {
                                        EmptyView()
                                   })
                    
                    RestaurantCellView(restaurant: restaurant)
                        .onAppear(perform: {
                            if restaurant == viewModel.restaurants.last {
                                viewModel.isLastRow = true
                            }
                        })
                }
                .onTapGesture {
                    isActiveDetails = true
                }
            }
        }
        .padding(.bottom)
        .prepareForLoadMore(loadMore: {
            viewModel.handleLoadMore()
        }, showIndicator: viewModel.canLoadMore && viewModel.isLastRow)
        .onRefresh {
            viewModel.handleRefreshData()
        }
        .navigationBarTitle("Popular", displayMode: .inline)
        .setupNavigationBar()
        .statusBarStyle(.lightContent)
        .handleHidenKeyboard()
        .handleErrors($viewModel.error)
        .addLoadingIcon($viewModel.isLoading)
        .setupNavigationBar()
        .navigationBarBackButton()
        .addEmptyView(isEmpty: viewModel.restaurants.isEmpty && !viewModel.isLoading)
    }
}

struct PopularRestaurantsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PopularRestaurantsView()
        }
    }
}
