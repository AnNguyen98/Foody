//
//  TabBarView.swift
//  Foody
//
//  Created by MBA0283F on 3/3/21.
//

import SwiftUI
import UIKit
import SwiftUIX

enum TabItem: Int, CaseIterable {
    case home = 0, search = 1, carts = 4, likes = 2, profile = 3
    
    var id: UUID { return UUID() }
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .carts:
            return "Carts"
        case .likes:
            return "Likes"
        case .search:
            return "Search"
        default:
            return "Profile"
        }
    }
    
    var imageName: SFSymbolName {
        switch self {
        case .home:
            return SFSymbolName.houseFill
        case .carts:
            return SFSymbolName.cart
        case .likes:
            return SFSymbolName.heartFill
        case .search:
            return SFSymbolName.magnifyingglass
        default:
            return SFSymbolName.personFill
        }
    }
    
    var color: Color {
        switch self {
        case .home:
            return .purple
        case .carts:
            return .blue
        case .likes:
            return .pink
        case .search:
            return .orange
        default:
            return .primary
        }
    }
}

struct BottomTabBar: View {
    var tabItems: [TabItem]
    @Binding var indexSelected: Int
    
    var body: some View {
        VStack {
            Divider()
            HStack(spacing: 30) {
                Spacer()
                
                ForEach(tabItems, id: \.id) { item in
                    TabBarItem(item: item, indexSelected: $indexSelected)
                }
                
                Spacer()
            }
        }
        .background(.white)
    }
}

struct TabBarItem: View {
    var item: TabItem
    @Binding var indexSelected: Int
    @State private var isClicking: Bool = false
    private var isSelected: Bool {
        item.rawValue == indexSelected
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: item.imageName)
                .resizable()
                .systemBold(size: 5)
                .frame(width: 17, height: 17)
            Text(isSelected ? item.title: "")
                .systemBold(size: 12)
                .padding(.leading, isSelected ? 5: 0)
        }
        .frame(width: isSelected ? 90: 30)
        .padding(.horizontal, isSelected ? 15: 5)
        .padding(.vertical, 10)
        .scaleEffect(isClicking ? 1.2: isSelected ? 1.1: 1)
        .animation(.interpolatingSpring(mass: 1.0, stiffness: 500,
                                        damping: 14, initialVelocity: 0.2))
       
        .foregroundColor(isSelected ? item.color: Color.gray)
        .background(isSelected ? item.color.opacity(0.3): Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .animation(.interpolatingSpring(mass: 1.0, stiffness: 200,
                                        damping: 20, initialVelocity: 0.1))
        .onTapGesture {
            indexSelected = item.rawValue
            isClicking = true
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (_) in
                isClicking = false
            }
        }
    }
}
