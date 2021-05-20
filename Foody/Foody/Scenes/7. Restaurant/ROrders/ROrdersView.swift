//
//  ROrdersView.swift
//  Foody
//
//  Created by MBA0283F on 5/20/21.
//

import SwiftUI
import SwiftUIX

struct ROrdersView: View {
    @StateObject private var viewModel = ROrdersViewModel()
    @State private var selectedColorIndex = 0
    @State private var editMode = false
    
    var body: some View {
        VStack {
            Picker("orders", selection: $selectedColorIndex, content: {
                Text("Processing").tag(0)
                Text("Canceled").tag(1)
                Text("Shipping").tag(2)
                Text("Paymented").tag(3)
            })
            .pickerStyle(SegmentedPickerStyle())
            .padding([.top, .horizontal], 10)
            
            LazyVStack {
                ForEach(0..<20) { index in
                    VStack {
                        HStack {
                            Circle()
                                .frame(width: 40, height: 40)
                                .background(
                                    Image("food1")
                                        .resizable()
                                )
                            
                            Text("An Nguyễn")
                            
                        }
                        
                        Divider()
                        
                        HStack {
                            HStack {
                                Image("food1")
                                    .resizable()
                                    .frame(width: 150, height: 90)
                                
                                VStack(spacing: 15) {
                                    HStack {
                                        Text("\(index)")
                                            .font(.title2)
                                        
                                        Spacer()
                                        
                                        Text("Today")
                                            .foregroundColor(.gray)
                                    }
                                    Text("Order ID: \(UUID().uuidString)")
                                }
                                .padding(.trailing)
                            }
                        }
                    }
                    .font(.body)
                    .lineLimit(1)
                    .frame(maxWidth: kScreenSize.width)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .gray, radius: 3, x: 2, y: 2)
                }
            }
            .prepareForLoadMore(loadMore: {
                
            }, showIndicator: true)
            .onRefresh {
                
            }
        }
        .navigationSearchBar({
            SearchBar("Enter product name...", text: $viewModel.searchText)
                .showsCancelButton(true)
                .searchBarStyle(.default)
                .returnKeyType(.search)
        })
        .navigationBarItems(
            leading: Text("Orders")
                .foregroundColor(.white)
                .font(.title)
                .bold()
        )
        .navigationBarTitle("", displayMode: .inline)
        .setupNavigationBar()
        .setupBackgroundNavigationBar()
        .addLoadingIcon($viewModel.isLoading)
        .handleErrors($viewModel.error)
    }
}

struct ROrdersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ROrdersView()
        }
    }
}
