//
//  NotificationsView.swift
//  Foody
//
//  Created by An Nguyễn on 04/05/2021.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        Button(action: {
            print("bell")
        }, label: {
            ZStack {
                Image(systemName: SFSymbols.bellFill)
                    .resizable()
                    .frame(width: 20, height: 20)
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.blue)
                    .offset(x: 6, y: -6)
            }
            .shadow(color: .white, radius: 10, x: 0.0, y: 0.0)
        })

    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
