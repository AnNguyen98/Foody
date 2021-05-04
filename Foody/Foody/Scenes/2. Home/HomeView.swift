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
        ZStack {
            Colors.redColorCustom
                .ignoresSafeArea()
            
            ScrollView {
                Section(header: headerView("Trending products")) {
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 20) {
                            ForEach(0..<10) {
                                Text("Item \($0)")
                                    .foregroundColor(.white)
                                    .font(.body)
                                    .frame(width: 100, height: 100)
                                    .background(Color.red)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                
                Section(header: headerView("Most popular")) {
                    LazyVStack(spacing: 20) {
                        ForEach(0..<10) {
                            Text("Item \($0)")
                                .foregroundColor(.white)
                                .font(.body)
                                .frame(width: 100, height: 100)
                                .background(Color.red)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                Spacer()
            }
            .padding(.top, 20)
            .background(Color.white)
        }
        .navigationBarItems(
            trailing: NotificationsView()
        )
        .navigationBarTitle("Home", displayMode: .large)
        .onAppear(perform: {
            let titleTextAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 34),
                .foregroundColor: UIColor.white,
            ]
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().largeTitleTextAttributes = titleTextAttributes
            UINavigationBar.appearance().barTintColor = Colors.redColorCustom.toUIColor
        })
        .statusBarStyle(.lightContent)
        .handleHidenKeyboard()
        .handleErrors($viewModel.error)
        .addLoadingIcon($viewModel.isLoading)
    }
}

extension HomeView {
    func headerView(_ title: String) -> some View {
        HStack {
            Text(title)
                .multilineTextAlignment(.leading)
                .systemBold(size: 17)
                .padding(.leading, 20)
            
            Spacer()
        }
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
