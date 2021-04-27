//
//  ProfileView.swift
//  Foody
//
//  Created by MBA0283F on 3/19/21.
//

import SwiftUI
import SwiftUIX

struct ProfileView: View {
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.1607843137, green: 0.1803921569, blue: 0.2156862745, alpha: 1))
                .ignoresSafeArea()
            
            Color(#colorLiteral(red: 0.1607843137, green: 0.2039215686, blue: 0.2588235294, alpha: 1))
                .padding(.top, kScreenSize.height / 3)
            
            VStack {
                Text("Profile")
                    .bold(size: 33)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color(#colorLiteral(red: 0.1607843137, green: 0.1803921569, blue: 0.2156862745, alpha: 1)))
                        .frame(maxHeight: kScreenSize.height / 3.5)
                        .shadow(color: Color.black.opacity(0.5), radius: 5, x: -1, y: 5)
                    
                    VStack {
                        Image("no-user")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .shadow(radius: 2)
                            .overlay(Circle().stroke(Color.white, lineWidth: 5))
                        
                        Text("James Wiliam")
                            .bold(size: 26)
                        Text("jameswili@gmail.com")
                            .bold(size: 17)
                    }
                    
                    Button(action: {
                        
                    }, label: Image("edit-icon"))
                    .offset(x: kScreenSize / 2 - 30, y: -kScreenSize.height / (3.5 * 2) + 40)
                }
                
                
                Spacer()
            }
            .foregroundColor(Color.white)
            .padding()
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
