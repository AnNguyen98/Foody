//
//  CartView.swift
//  Foody
//
//  Created by MBA0283F on 3/19/21.
//

import SwiftUI

struct CartView: View {
    @Environment(\.presentationMode) private var presentationMode
    //@Environment(\.editMode)
    @State private var editMode = false
    
    var body: some View {
        NavigationView {
            LazyVStack {
                ForEach(0..<20) { index in
                    HStack {
//                        if editMode {
//                            Button(action: {
//
//                            }, label: {
//                                Image(systemName: SFSymbols.trash)
//                            })
//                        }
                        
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
//            .environment(\.editMode, $editMode)
            .prepareForLoadMore(loadMore: {
                
            }, showIndicator: true)
            .onRefresh {
                
            }
            .navigationBarTitle("My Orders", displayMode: .inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.dismiss()
                    }, label: Image(systemName: SFSymbols.xmark))
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        editMode.toggle()
                    }, label: Text(editMode ? "Done": "Edit"))
                }
            })
            .onAppear(perform: {
                UINavigationBar.appearance().tintColor = .gray
            })
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
