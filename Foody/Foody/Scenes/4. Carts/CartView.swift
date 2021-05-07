//
//  CartView.swift
//  Foody
//
//  Created by MBA0283F on 3/19/21.
//

import SwiftUI

struct CartView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.editMode) var editMode = EditMode.inactive
//    @State private var editMode = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<20) { index in
                    HStack {
//                        if editMode {
//                            Button(action: {
//
//                            }, label: {
//                                Image(systemName: SFSymbols.checkmarkCircleFill)
//                                    .resizable()
//                                    .frame(width: 20, height: 20)
//                                    .foregroundColor(.gray)
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
//                        .disabled()
                        .font(.body)
                        .lineLimit(1)
                        .frame(maxWidth: kScreenSize.width)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: .gray, radius: 3, x: 2, y: 2)
                        
//                        if editMode {
//                            Button(action: {
//
//                            }, label: {
//                                Image(systemName: SFSymbols.trash)
//                            })
//                        }
                    }
                    .animation(.default)
                }
                
                Button(action: {
                    
                }, label: {
                    Text("Complete Order")
                    
                })
            }
//            .prepareForLoadMore(loadMore: {
//
//            }, showIndicator: true)
            .onRefresh {
                
            }
            .navigationBarTitle("Carts", displayMode: .inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.dismiss()
                    }, label: Image(systemName: SFSymbols.xmark))
                }
                
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        editMode.toggle()
//                    }, label: Text(editMode ? "Done": "Edit"))
//                }
            })
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
