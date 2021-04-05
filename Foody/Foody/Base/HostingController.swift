//
//  HostingController.swift
//  Foody
//
//  Created by An Nguyễn on 4/5/21.
//

import SwiftUI

final class HostingController<ContentView>: UIHostingController<ContentView> where ContentView: View {
    override var preferredStatusBarStyle: UIStatusBarStyle {
//        if type(of: ContentView.self) == OnboardingView.self {
//            return .darkContent
//        }
        return .lightContent
    }
}
