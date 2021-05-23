//
//  FloatButtonView.swift
//  Foody
//
//  Created by MBA0283F on 5/23/21.
//

import SwiftUI

extension View {
    var isResraurant: Bool {
        true //Session.shared.isResraurant
    }
}

struct FloatButtonView: View {
    @State private var showOrdersView: Bool = false
    
    var body: some View {
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
    }
}

struct FloatButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FloatButtonView()
    }
}
