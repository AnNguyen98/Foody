//
//  RTabView.swift
//  Foody
//
//  Created by MBA0283F on 5/23/21.
//

import SwiftUI

struct RTabViews: View {
    @State private var indexSelected: Int = 0
    
    var body: some View {
        VStack {
            UIKitTabView(selectedIndex: $indexSelected) {
                
                UIKitTabView.Tab(view: NavigationView { RHomeView() }.toAnyView )
                
                UIKitTabView.Tab(view: NavigationView { ROrdersView() }.toAnyView)
                                    
                UIKitTabView.Tab(view: NavigationView { RChartsView() }.toAnyView)
                
                UIKitTabView.Tab(view: NavigationView { ProfileView() }.toAnyView)
            }
            
            BottomTabBar(tabItems: [.home, .orders, .charts, .profile], indexSelected: $indexSelected)
                .frame(maxWidth: kScreenSize.width)
                .padding(.bottom, 20)
        }
        .ignoresSafeArea()
    }
}

struct RTabView_Previews: PreviewProvider {
    static var previews: some View {
        RTabViews()
    }
}