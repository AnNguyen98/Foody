//
//  ProfileView.swift
//  Foody
//
//  Created by MBA0283F on 3/19/21.
//

import SwiftUI

struct ContentUI: Hashable, Identifiable {
    var id: String = UUID().uuidString
    var icon: String
    var title: String
    
    init(_ icon: String, _ title: String) {
        self.icon = icon
        self.title = title
    }
}

struct ProfileView: View {
    
    var contents: [ContentUI] = [
        ContentUI("account-icon", "Account"),
        ContentUI("storage-icon", "Storage"),
        ContentUI("noti-icon", "Notification"),
        ContentUI("info-icon", "Application Info"),
        ContentUI("help-icon", "Help Center"),
        ContentUI("logout-icon", "Logout")
    ]
    
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
            
            List(contents) { content in
                if content.title == "Logout" {
                    HStack {
                        Image(content.icon)
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text(content.title)
                            .regular(size: 14)
                    }
                    .frame(height: 56)
                    .onTapGesture {
                        
                    }
                } else {
                    NavigationLink(
                        destination: Text("Destination"),
                        label: {
                            HStack {
                                Image(content.icon)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                Text(content.title)
                                    .regular(size: 14)
                            }
                            .frame(height: 56)
                        }
                    )
                }
            }
            .listStyle(InsetListStyle())
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
