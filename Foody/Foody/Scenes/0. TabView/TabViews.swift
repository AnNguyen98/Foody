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
    @State private var offset: CGSize = .zero
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                if isResraurant {
                    UIKitTabView(selectedIndex: $indexSelected) {
                        
                        UIKitTabView.Tab(view: NavigationView { RHomeView() }.toAnyView )
                        
                        UIKitTabView.Tab(view: NavigationView { ROrdersView() }.toAnyView)
                                            
                        UIKitTabView.Tab(view: RChartsView().toAnyView)
                        
                        UIKitTabView.Tab(view: NavigationView { ProfileView() }.toAnyView)
                    }
                } else {
                    UIKitTabView(selectedIndex: $indexSelected) {
                        
                        UIKitTabView.Tab(view: NavigationView { HomeView() }.toAnyView )
                        
                        UIKitTabView.Tab(view: NavigationView { SearchView() }.toAnyView)
                                            
                        UIKitTabView.Tab(view: NavigationView { FavoritesView() }.toAnyView)
                        
                        UIKitTabView.Tab(view: NavigationView { ProfileView() }.toAnyView)
                    }
                }
                
                Button(action: {
                    showOrdersView = true
                }, label: {
                    if isResraurant {
                        Image(systemName: SFSymbols.plus)
                            .resizable()
                            .frame(.init(width: 20, height: 20))
                            .foregroundColor(.white)
                            .shadow(color: .gray, radius: 1, x: 0.0, y: 0.0)
                            .padding(20)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: .gray, radius: 2, x: 0.0, y: 0.0)
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        print("DRAG", gesture.translation)
                                        offset = gesture.translation
                                    }
                            )
                    } else {
                        GifView(gifName: "cart-preview")
                            .frame(.init(width: 70, height: 70))
                            .clipShape(Circle())
                            .blur(radius: 0.5)
                            .shadow(color: .gray, radius: 2, x: 0.0, y: 0.0)
                        
                    }
                })
                .padding()
                .fullScreenCover(isPresented: $showOrdersView, content: {
                    if isResraurant {
                        RAddProductView(isActive: $showOrdersView)
                    } else {
                        OrdersView()
                    }
                })
//                .offset(offset)
            }
            
            BottomTabBar(tabItems: tabItems, indexSelected: $indexSelected)
                .frame(maxWidth: kScreenSize.width)
                .padding(.bottom, 20)
        }
        .ignoresSafeArea()
    }
}

extension TabViews {
    private var tabItems: [TabItem] {
        if isResraurant {
            return [.home, .orders, .charts, .profile]
        }
        return [.home, .search, .likes, .profile]
    }
    
    private var isResraurant: Bool {
        true //Session.shared.isResraurant
    }
}

struct TabViews_Previews: PreviewProvider {
    static var previews: some View {
        TabViews()
    }
}
