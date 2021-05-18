//
//  OrderView.swift
//  Foody
//
//  Created by MBA0283F on 4/8/21.
//

import SwiftUI

struct OrdersView: View {
    @StateObject private var viewModel = OrdersViewModel()
    @State private var selectedColorIndex = 0
    @State private var editMode = false

    var body: some View {
        VStack {
            Picker("Favorite Color", selection: $selectedColorIndex, content: {
                Text("To Pay").tag(0)
                Text("To Ship").tag(1)
                Text("To Receive").tag(2)
                Text("To Completed").tag(3)
            })
            .pickerStyle(SegmentedPickerStyle())
            
            LazyVStack {
                ForEach(0..<20) { index in
                    HStack {
                        if editMode {
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: SFSymbols.checkmarkCircleFill)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.gray)
                            })
                        }
                        
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
                        .disabled(editMode)
                        .font(.body)
                        .lineLimit(1)
                        .frame(maxWidth: kScreenSize.width)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: .gray, radius: 3, x: 2, y: 2)
                        
                        if editMode {
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: SFSymbols.trash)
                            })
                        }
                    }
                    .animation(.default)
                }
            }
            .prepareForLoadMore(loadMore: {
                
            }, showIndicator: true)
            .onRefresh {
                
            }
        }
        .navigationBarTitle("My Orders", displayMode: .inline)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    editMode.toggle()
                }, label: Text(editMode ? "Done": "Edit"))
            }
        })
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}
