//
//  HomeView.swift
//  Foody
//
//  Created by MBA0283F on 3/4/21.
//

import SwiftUI
//import ImagePicker

struct HomeView: View {
    
    @State private var shadowRadius: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Home")
                        .bold(size: 34)
                    Spacer()
                    Button(action: {
                        print("bell")
                    }, label: {
                        ZStack {
                            Image(systemName: "bell.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.blue)
                                .offset(x: 6, y: -6)
                        }
                        .shadow(color: .white, radius: 10, x: 0.0, y: 0.0)
                    })
                }
                Button(action: {
                    print("Search")
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .padding(.leading, 10)
                    Text("Search...")
                        .regular(size: 17)
                    Spacer()
                })
                .frame(maxWidth: .infinity, maxHeight: 40)
                .foregroundColor(#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1).color)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.top, 5)
            }
            .padding()
            .background(Colors.redColorCustom)
            .foregroundColor(.white)
            
            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
