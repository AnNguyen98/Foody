//
//  ProfileView.swift
//  Foody
//
//  Created by MBA0283F on 3/19/21.
//

import SwiftUI
import SwiftUIX

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.1607843137, green: 0.1803921569, blue: 0.2156862745, alpha: 1))
                .ignoresSafeArea()
            
            Color.white
                .padding(.top, kScreenSize.height / 3)
            
            VStack {
                Text("Profile")
                    .systemBold(size: 34)
                    .foregroundColor(.white)

                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.white)
                        .frame(maxHeight: kScreenSize.height / 3.5)
                        .shadow(color: Color.gray, radius: 2, x: -1, y: 2)

                    VStack {
                        Image("no-user")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .shadow(radius: 2)
                            .overlay(Circle().stroke(Color.gray, lineWidth: 5))

                        HStack {
                            Text("James Wiliam")
                                .bold(size: 26)

                            Image(systemName: SFSymbolName.checkmarkCircleFill)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.green)
                                .background(
                                    Circle()
                                        .foregroundColor(.white)
                                )
                        }
                        Text("jameswili@gmail.com")
                            .bold(size: 17)
                    }
                    .padding(.vertical)

                    NavigationLink(
                        destination: Text("Destination"),
                        label: {
                            Image("edit-icon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30)
                        })
                        .offset(x: kScreenSize.width / 2 - 50, y: -kScreenSize.height / (3.5 * 2) + 30)
                        .foregroundColor(.gray)
                }

                ProfileButtonView(action: {
                    
                }, text: "Infomation", imageName: "account-icon")
                .padding(.top, 35)

                if viewModel.isRestaurant {
                    ProfileButtonView(action: {

                    }, text: "Chart", imageName: "chart-icon")
                }

                ProfileButtonView(action: {
                    openUrl(url: Config.applicationInfoUrl)
                }, text: "About application", imageName: "info-icon")
                
                ProfileButtonView(action: {
                    openUrl(url: Config.helpUrl)
                }, text: "Help", imageName: "help-icon")
                
                ProfileButtonView(action: {
                    logout()
                }, text: "Logout", imageName: "logout-icon")
                .padding(.bottom, 30)
                
                Spacer()
            }
            .padding()
        }
        .navigationBarHidden(true)
        .statusBarStyle(.lightContent)
    }
}

extension ProfileView {
    private func openUrl(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        UIApplication.shared.open(url, options: [:])
    }
    
    private func logout() {
        Session.shared.reset()
        makeRoot(.login)
    }
}

extension ProfileView {
    struct Config {
        // TODO: - UPDATE WEBSITE
        static let helpUrl: String = "https://www.mongodb.com/"
        static let applicationInfoUrl: String = "https://www.mongodb.com/"
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}
