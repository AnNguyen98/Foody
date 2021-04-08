//
//  SplashView.swift
//  Foody
//
//  Created by An Nguyễn on 2/18/21.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                NavigationLink(
                    destination: OnboardingView(),
                    isActive: $isActive,
                    label: {  Text("") }
                )
                Color(#colorLiteral(red: 0.9607843137, green: 0.1764705882, blue: 0.337254902, alpha: 1))
                
                VStack {
                    Image("logo")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Text("Foody")
                        .bold(size: 40)
                        .foregroundColor(.white)
                    Spacer()
                }
                .fixedSize()
            }
            .navigationBarHidden(true)
            .ignoresSafeArea()
            .onAppear(perform: {
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (_) in
                    isActive = true
                }
            })
            .statusBarStyle(.lightContent)
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
