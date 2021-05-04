//
//  HomeView.swift
//  Foody
//
//  Created by MBA0283F on 3/4/21.
//

import SwiftUI
import SwiftUIX

struct HomeView: View {
    
    @State private var shadowRadius: Bool = false
    
    var body: some View {
        ZStack {
//            Color.red
            
            CocoaScrollView(.vertical, content: {
                VStack {
                    ForEach(0..<40) { (index) in
                        Text("Row -- \(index)")
                            .padding(.vertical)
                            .background(Color.green)
                    }
                }
            })
            .onRefresh {
                print("OKKKK")
            }
            .isRefreshing(false)
            .refreshControlTintColor(.black)
            .isScrollEnabled(true)
            .navigationSearchBarHiddenWhenScrolling(true)
            .navigationBarItems(trailing:
                                    Button(action: {
                                        print("bell")
                                    }, label: {
                                        ZStack {
                                            Image(systemName: SFSymbolName.bellFill)
                                                .resizable()
                                                .frame(width: 20, height: 20)
                                            Circle()
                                                .frame(width: 10, height: 10)
                                                .foregroundColor(.blue)
                                                .offset(x: 6, y: -6)
                                        }
                                        .shadow(color: .white, radius: 10, x: 0.0, y: 0.0)
                                    })
            )
            .navigationBarTitle("Home", displayMode: .automatic)
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}
