//
//  NotificationsView.swift
//  Foody
//
//  Created by MBA0283F on 5/19/21.
//

import SwiftUI

struct RNotificationsView: View {
    @StateObject private var viewModel = RNotificationsViewModel()
    @Binding var isActive: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.notifications, id: \._id) { notification in
                        VStack(alignment: .leading) {
                            HStack(spacing: 10) {
                                Image("default-thumbnail")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60 * scale, height: 60 * scale)
                                    .clipShape(Circle())
                                
                                VStack(spacing: 5) {
                                    Text(notification.content)
                                        .lineLimit(3)
                                        .font(.system(size: 16))
                                    
                                    HStack {
                                        Spacer()
                                        
                                        Text(notification.time) //1h/ 1day
                                            .font(.system(size: 14))
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding(.top)
                            }
                            .onTapGesture {
                                viewModel.markReadNotification(notification)
                            }
                            
                            Divider()
                        }
                    }
                }
                .padding()
                .font(.body)
            }
            .onRefresh {
                viewModel.getNotifications()
            }
            .navigationBarItems(
                leading: Button(action: {
                    isActive.toggle()
                }, label: {
                    Image(systemName: SFSymbols.xmark)
                        .foregroundColor(.white)
                        .padding(2)
                })
            )
            .addLoadingIcon($viewModel.isLoading)
            .addEmptyView(isEmpty: !viewModel.isLoading && viewModel.notifications.isEmpty)
            .navigationBarTitle(Text("Notifications"), displayMode: .inline)
            .handleErrors($viewModel.error)
            .foregroundColor(.black)
            .statusBarStyle(.lightContent)
        }
        .onAppear(perform: {
            viewModel.getNotifications()
        })
    }
}

struct RNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RNotificationsView(isActive: .constant(true))
        }
    }
}
