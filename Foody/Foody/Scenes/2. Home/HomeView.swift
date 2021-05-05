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
            Section(header: headerView("Trending products",  destination: AnyView(Text("destination")))) {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 20) {
                        ForEach(0..<10) { item in
                            NavigationLink(destination: Text("OKK"), label: {
                                ProductCellView()
                            })
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            
            Section(header: headerView("Most popular", destination: AnyView(Text("destination")))) {
                LazyVStack(spacing: 20) {
                    ForEach(0..<10) { item in
                        NavigationLink(destination: Text("OKK"), label: {
                            RestaurantCellView()
                        })
                    }
                }
                .padding([.horizontal, .bottom], 20)
            }
        }
        .onRefresh {
            
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
    }
}

extension HomeView {
    func headerView(_ title: String, destination: AnyView) -> some View {
        HStack {
            Text(title)
                .multilineTextAlignment(.leading)
                .font(.title3)
            
            Spacer()
            
            NavigationLink(
                destination: destination,
                label: {
                    Text("See more")
                        .underline()
                        .font(.body)
                        .foregroundColor(.black)
                })
        }
        .padding([.horizontal, .top], 20)
        .padding(.bottom, 5)
    }

}

extension HomeView {
    class HomeViewObject: NSObject {
        @objc func refreshData(_ refreshControl: UIRefreshControl) {
            print("OKKKK")
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                refreshControl.endRefreshing()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}
