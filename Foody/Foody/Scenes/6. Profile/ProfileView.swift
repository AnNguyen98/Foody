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
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                ZStack {
                    Image(viewModel.restaurant.dataImages.first)
                        .resizable()
                        .frame(maxHeight: kScreenSize.height / 3.5)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 20)
                        )
                        .shadow(color: Color.gray, radius: 2, x: 0, y: 0)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.white)
                        .frame(maxHeight: kScreenSize.height / 3.5)
                        .shadow(color: Color.gray, radius: 2, x: 0, y: 0)
                        .hidden(!viewModel.restaurant.dataImages.isEmpty)

                    VStack {
                        Image(viewModel.user.imageProfile, isProfile: true)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .shadow(radius: 2)
                            .overlay(Circle().stroke(Color.gray, lineWidth: 5))

                        HStack {
                            Text(viewModel.user.username)
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
                        Text(viewModel.user.email)
                            .bold(size: 17)
                    }
                    .padding(.vertical)

                    NavigationLink(
                        destination: UpdateInfoView(),
                        label: {
                            Image("edit-icon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30)
                        })
                        .offset(x: kScreenSize.width / 2 - 50, y: -kScreenSize.height / (3.5 * 2) + 30)
                        .foregroundColor(.gray)
                }

                ScrollView(showsIndicators: false) {
                    if viewModel.isRestaurant {
                        ProfileButtonView(text: Text(viewModel.restaurant.name).bold(), symbol: SFSymbols.houseFill)
                            .padding(.top, 30)
                            .disabled(true)
                    }

                    ProfileButtonView(text:
                                        Text(viewModel.user.phoneNumber)
                                            .foregroundColor(.blue),
                                      symbol: SFSymbols.phone)
                        .disabled(true)
                    
                    ProfileButtonView(text: Text(viewModel.restaurant.address), symbol: SFSymbols.locationFill)
                        .disabled(true)

                    ProfileButtonView(action: {
                            openUrl(url: Config.applicationInfoUrl)
                    }, text: Text("About application"), imageName: "info-icon")
                    
                    ProfileButtonView(action: {
                        openUrl(url: Config.helpUrl)
                    }, text: Text("Help"), imageName: "help-icon")
                    
                    ProfileButtonView(action: {
                        logout()
                    }, text: Text("Logout"), imageName: "logout-icon")
                    .padding(.bottom, 30)
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .statusBarStyle(.lightContent)
        .addLoadingIcon($viewModel.isLoading)
        .handleErrors($viewModel.error)
        .onReceive(viewModel.$isLogged, perform: { isLogged in
            if !isLogged {
                makeRoot(.login)
            }
        })
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
        viewModel.logout()
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
