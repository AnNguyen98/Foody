//
//  ContentView.swift
//  Foody
//
//  Created by An Nguyễn on 2/18/21.
//

import SwiftUI

var kScreenSize: CGSize {
    UIScreen.main.bounds.size
}

let mainColor: UIColor = #colorLiteral(red: 0.9607843137, green: 0.1764705882, blue: 0.337254902, alpha: 1)
let scale: CGFloat = 815 / kScreenSize.height

struct OnboardingView: View {
    @State private var isActive: Bool = false
    @State private var currentIndex: Int = 0
    
    private let sizeContent: CGFloat =  285 / 815 * kScreenSize.height
    private var titles: [String] = ["Discover place near you", "Choose A Tasty Dish", "Pick Up Or Delivery"]
    private var descriptions: [String] = [
        "We make it simple to find the food you crave. Enter your address and let us do the rest.",
        "When you order Eat Street, we'll hook you up with exclusive coupons, specials and rewards.",
        "We make food ordering fast, simple and free - no matter if you order online or cash."
    ]
    
    var body: some View {
        VStack (spacing: 15) {
            HStack {
                Spacer()
                NavigationLink(
                    destination: LoginView(),
                    isActive: $isActive,
                    label: {
                        HStack(alignment: .center, spacing: 2, content: {
                            Text("Skip")
                                .font(.system(size: 16))
                                .foregroundColor(Color(#colorLiteral(red: 0.9607843137, green: 0.1764705882, blue: 0.337254902, alpha: 1)))
                            Image("skip_icon")
                                .resizable()
                                .frame(width: 10, height: 10)
                        })
                        .onTapGesture(perform: {
                            isActive.toggle()
                        })
                    })
                    .padding(.horizontal)
            }
            
            
            TabView(selection: $currentIndex) {
                ForEach(0..<titles.count) { value in
                    VStack (alignment: .center, spacing: 20) {
                        Image("onboarding\(value)")
                            .resizable()
                            .frame(width: sizeContent, height: sizeContent)
                        
                        VStack {
                            Text(titles[value])
                                .regular(size: 36)
                                .padding([.horizontal, .bottom], 15)
                                .frame(height: 110)
                                .lineLimit(2)
                            
                            Text(descriptions[value])
                                .regular(size: 17)
                                .padding(.horizontal, 20)
                            
                        }
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(#colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1568627451, alpha: 1)))
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onAppear(perform: {
                UIScrollView.appearance().bounces = false
            })
            
            VStack(spacing: 10) {
                if currentIndex == 2 {
                    Button(action: {
                        isActive.toggle()
                    }, label: {
                        Text("Get Started")
                            .foregroundColor(.white)
                            .frame(width: 200, height: 45)
                            .background(Color(#colorLiteral(red: 0.9607843137, green: 0.1764705882, blue: 0.337254902, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    })
                }
                
                HStack(spacing: 0){
                    ForEach(0..<3) {
                        RoundedRectangle(cornerRadius: 6)
                            .frame(width: 30, height: 6)
                            .foregroundColor(currentIndex == $0 ? Color(#colorLiteral(red: 0.9607843137, green: 0.1764705882, blue: 0.337254902, alpha: 1)): Color(#colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1)))
                    }
                }
                .background(
                    Color(.clear)
                        .overlay(RoundedRectangle(cornerRadius: 6)
                                    .foregroundColor(Color(#colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1))))
                )
                .padding(.top, currentIndex != 2 ? 55: 0)
            }
            .padding(.bottom, 20)
        }
        .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
