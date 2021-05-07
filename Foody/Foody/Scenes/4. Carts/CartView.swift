//
//  CartView.swift
//  Foody
//
//  Created by MBA0283F on 3/19/21.
//

import SwiftUI

struct CartView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var value = 1
    
    var body: some View {
        NavigationView {
            VStack {
                LazyVStack(spacing: 15) {
                    ForEach(0..<15) { index in
                        SwipeableView(content: {
                            HStack {
                                Image("food1")
                                    .resizable()
                                    .frame(width: 150)

                                VStack(spacing: 15) {
                                    HStack {
                                        Text("\(value)")
                                            .font(.title2)

                                        Spacer()

                                        Text("Today")
                                            .foregroundColor(.gray)
                                    }
                                    
                                    HStack {
                                        Text("Order ID: \(UUID().uuidString)")
                                        
                                        Spacer()
                                        
                                        SteperLabel(value: $value)
                                    }
                                }
                                .padding(.trailing)
                            }
                            .font(.body)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: .gray, radius: 3, x: 0, y: 0)
                        },
                        leftActions: [
                            Action(title: "Delete", iconName: SFSymbols.trash.rawValue, bgColor: .red, action: {
                                
                            }),
                        ], rightActions: [],
                        rounded: true
                        ).frame(height: 90)
                    }
                }
                .prepareForLoadMore(loadMore: {

                }, showIndicator: true)
                .onRefresh {
                    
                }
                
                Divider()
                
                Button(action: {
                    
                }, label: {
                    Text("Complete order")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Colors.redColorCustom)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                })
                .padding([.bottom, .horizontal])
            }
            .navigationBarTitle("Carts", displayMode: .inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.dismiss()
                    }, label: Image(systemName: SFSymbols.xmark))
                }
            })
        }
    }
    
    func delete(at offsets: IndexSet) {
        //users.remove(atOffsets: offsets)
        print(offsets)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
