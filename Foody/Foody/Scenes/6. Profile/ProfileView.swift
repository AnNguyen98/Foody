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
            
            ScrollView {
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

                            HStack {
                                Text("James Wiliam")
                                    .bold(size: 26)
                                
                                Image(systemName: SFSymbolName.checkmarkCircleFill)
                                    .resizable()
                                    .frame(.init(width: 20, height: 20))
                                    .foregroundColor(Color.green)
                                    .background(
                                        Circle()
                                            .foregroundColor(Color.white)
                                    )
                            }
                            Text("jameswili@gmail.com")
                                .bold(size: 17)
                        }
                        .padding(.vertical)
                        
                        Button(action: {
                            editInfo()
                        }, label: {
                            Image("edit-icon")
                        })
                        .offset(x: kScreenSize.width / 2 - 50, y: -kScreenSize.height / (3.5 * 2) + 30)
                    }
                    
                    
                    ProfileButtonView(action: {
                        
                    }, text: "User infomation", imageName: "account-icon")
                    .padding(.top, 50)
                    
                    ProfileButtonView(action: {
                        
                    }, text: "Chart", imageName: "chart-icon")

                    
                    ProfileButtonView(action: {
                        
                    }, text: "About application", imageName: "info-icon")
                    
                    ProfileButtonView(action: {
                        
                    }, text: "Help", imageName: "help-icon")
                    
                    ProfileButtonView(action: {
                        
                    }, text: "Logout", imageName: "logout-icon")
                    .padding(.bottom, 30)
                }
            }
            
            .foregroundColor(Color.white)
            .padding()
        }
        .navigationBarHidden(true)
        .statusBarStyle(.lightContent)
    }
}

extension ProfileView {
    private func editInfo() {
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}
