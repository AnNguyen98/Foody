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
                Section(header: headerView("Trending products",  destination: AnyView(Text("destination")))) {
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 20) {
                            ForEach(0..<10) { item in
                                NavigationLink(destination: Text("OKK"), label: {
                                    ProductCellView()
                                })
                            }
                        }
                        .padding(.leading, 20)
                    }
                }
                
                Section(header: headerView("Most popular", destination: AnyView(Text("destination")))) {
                    LazyVStack(spacing: 20) {
                        ForEach(0..<10) { item in
                            NavigationLink(destination: Text("OKK"), label: {
                                Text("Item \(item)")
                                    .foregroundColor(.white)
                                    .font(.body)
                                    .frame(width: kScreenSize.width - 40, height: 182)
                                    .background(Color.red)
                            })
                        }
                    }
                    .padding([.horizontal, .bottom], 20)
                }
                
                Spacer()
            }
            .background(Color.white)
        }
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

extension View {
    func setupNavigationBar(titleSize: CGFloat = 20, largeTitleSize: CGFloat = 34, titleCOlor: UIColor = .white) -> some View {
        self
            .onAppear(perform: {
                UINavigationBar.appearance().tintColor = .white
                UINavigationBar.appearance().largeTitleTextAttributes = [
                    .font: UIFont.boldSystemFont(ofSize: largeTitleSize),
                    .foregroundColor: titleCOlor,
                ]
                UINavigationBar.appearance().titleTextAttributes = [
                    .font: UIFont.boldSystemFont(ofSize: titleSize),
                    .foregroundColor: titleCOlor,
                ]
                UINavigationBar.appearance().barTintColor = Colors.redColorCustom.toUIColor
            })
    }
}

extension HomeView {
    func headerView(_ title: String, destination: AnyView) -> some View {
        HStack {
            Text(title)
                .multilineTextAlignment(.leading)
                .bold(size: 20)
            
            Spacer()
            
            NavigationLink(
                destination: destination,
                label: {
                    Text("See more")
                        .underline()
                        .bold(size: 15)
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
