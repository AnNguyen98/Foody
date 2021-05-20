//
//  TabViews.swift
//  Foody
//
//  Created by MBA0283F on 3/4/21.
//

import SwiftUI

struct TabViews: View {
    @State private var indexSelected: Int = 0
    @State private var showOrdersView: Bool = false
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                UIKitTabView(selectedIndex: $indexSelected) {
                    UIKitTabView.Tab(view: NavigationView { HomeView() }.toAnyView )
                    
                    UIKitTabView.Tab(view: NavigationView { SearchView() }.toAnyView)
                                        
                    UIKitTabView.Tab(view: NavigationView { FavoritesView() }.toAnyView)
                    
                    UIKitTabView.Tab(view: NavigationView { ProfileView() }.toAnyView)
                    
                }
                
                Button(action: {
                    showOrdersView = true
                }, label: {
                    GifView(gifName: "cart-preview")
                        .frame(.init(width: 70, height: 70))
                        .clipShape(Circle())
                        .blur(radius: 0.5)
                        .shadow(color: .gray, radius: 2, x: 0.0, y: 0.0)
                })
                .padding()
                .fullScreenCover(isPresented: $showOrdersView, content: {
                    OrdersView()
                })
            }
            
            BottomTabBar(tabItems: [.home, .search, .likes, .profile],
                         indexSelected: $indexSelected)
                .frame(maxWidth: kScreenSize.width)
                .padding(.bottom, 20)
        }
        .ignoresSafeArea()
    }
}

struct TabViews_Previews: PreviewProvider {
    static var previews: some View {
        TabViews()
    }
}
