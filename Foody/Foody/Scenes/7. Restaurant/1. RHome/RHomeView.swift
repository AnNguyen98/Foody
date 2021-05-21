
//
//  HomeView.swift
//  Foody
//
//  Created by MBA0283F on 3/4/21.
//

import SwiftUI
import SwifterSwift
import SwiftUIX

struct RHomeView: View {
    @StateObject private var viewModel = RHomeViewModel()
    @State private var isNotificationsPresented = false
        
    var body: some View {
        LazyVStack(spacing: 15) {
            ForEach(viewModel.products, id: \._id) { product in
                NavigationLink(destination: RFoodDetailsView(), label: {
                    VStack(alignment: .leading, spacing: 5) {
                        Image(product.productImages.first)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxHeight: 250 * scale)
                            .clipShape(RoundedRectangle(cornerRadius: 0))

                        VStack(alignment: .leading, spacing: 2) {
                            Text(product.name)
                            
                            Text(product.restaurantName)
                                .foregroundColor(Color(#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)))
                                .font(.subheadline)
                            
                            HStack(spacing: 5) {
                                ForEach(0..<5) { index in
                                    Image(systemName: SFSymbols.starFill)
                                        .resizable()
                                        .frame(width: 16 * scale, height: 16 * scale)
                                        .foregroundColor(index <= product.voteCount ? .yellow: .gray)
                                }
                                
                                Spacer(minLength: 0)
                                
                                Text("\(product.price) vnđ")
                                    .font(.title3)
                                    .bold()
                            }
                            .padding(.bottom, 10)
                        }
                        .font(.body)
                        .foregroundColor(Color(#colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1568627451, alpha: 1)))
                        .lineLimit(1)
                        .padding(.horizontal, 10)
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .gray, radius: 2, x: 0.0, y: 0)
                    .padding(.bottom, 15)
                    .onAppear(perform: {
                        if product == viewModel.products.last {
                            viewModel.isLastRow = true
                        }
                    })
                })
            }
        }
        .prepareForLoadMore(loadMore: {
            handleLoadMore()
        }, showIndicator: viewModel.canLoadMore)
        .onRefresh {
            refreshData()
        }
        .setupBackgroundNavigationBar()
        .navigationSearchBar({
            SearchBar("Enter product name...", text: $viewModel.searchText)
                .showsCancelButton(true)
                .searchBarStyle(.default)
                .returnKeyType(.search)
        })
        .navigationBarItems(
            trailing: NotificationView(action: {
                isNotificationsPresented.toggle()
            })
        )
        .navigationBarTitle("Home", displayMode: .automatic)
        .setupNavigationBar()
        .statusBarStyle(.lightContent)
        .handleHidenKeyboard()
        .handleErrors($viewModel.error)
        .addLoadingIcon($viewModel.isLoading)
        .fullScreenCover(isPresented: $isNotificationsPresented, content: {
            RNotificationsView(isActive: $isNotificationsPresented)
        })
        
    }
}

extension RHomeView {
    private func handleLoadMore() {
        viewModel.handleLoadMore()
    }
    
    func refreshData() {
        viewModel.refreshData()
    }
}

struct RHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RHomeView()
        }
    }
}
