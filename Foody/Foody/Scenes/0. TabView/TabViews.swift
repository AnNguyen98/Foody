//
//  TabViews.swift
//  Foody
//
//  Created by MBA0283F on 3/4/21.
//

import SwiftUI

struct TabViews: View {
    @State var tabItem: TabItems = .home
    
    var body: some View {
        VStack {
//            UIKitTabView.init()
            
            Spacer()
            BottomTabBar(currentItem: $tabItem)
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
