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
            ZStack {
                NavigationLink(
                    destination: Session.shared.isShowedOnboarding ? AnyView(LoginView()): AnyView(OnboardingView()),
                    isActive: $isActive,
                    label: {  EmptyView() }
                )
                                
                GifView(gifName: "splash-bg")
                    .frame(width: kScreenSize.width)
                    .clipped()
                    .ignoresSafeArea()
                
                VStack {
                    Image("logo")
                        .resizable()
                        .frame(width: 85, height: 85)
                        .shadow(color: .gray, radius: 2, x: 0.0, y: 0.0)
                    
                    Text("Fast Food")
                        .font(.largeTitle)
                        .foregroundColor(Color.black.opacity(0.7))
                    
                    Spacer()
                }
                .offset(x: 0, y: 100)
                
            }
            .navigationBarHidden(true)
            .ignoresSafeArea()
            .onAppear(perform: {
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (_) in
                    if let _ = Session.shared.user {
                        SceneDelegate.shared.makeRoot(.logged)
                    } else {
                        isActive = true
                    }
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
