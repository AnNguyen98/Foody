//
//  ProfileView.swift
//  Foody
//
//  Created by MBA0283F on 3/19/21.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        VStack {
            Text("Profile")
                .bold(size: 33)
            
            HStack {
                Image("onboarding0")
                    .resizable()
                    .frame(width: 60, height: 60)
                
                VStack {
                    HStack {
                        Text("An Nguyễn")
                        Image("check-icon")
                            
                    }
                    Text("corkery_dakota@gmail.com")
                }
            }
            
            
        }
        .navigationBarHidden(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}
