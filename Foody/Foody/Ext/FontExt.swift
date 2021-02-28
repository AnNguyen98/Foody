//
//  FontExt.swift
//  Foody
//
//  Created by An Nguyễn on 2/27/21.
//

import SwiftUI

struct BoldViewModifier: ViewModifier {
    var size: CGFloat = 18
    
    func body(content: Content) -> some View {
        content
            .font(.custom(Fonts.sourceSansProBold, size: size))
    }
}

struct RegularViewModifier: ViewModifier {
    var size: CGFloat = 15
    
    func body(content: Content) -> some View {
        content
            .font(.custom(Fonts.sourceSansProRegular, size: size))
    }
}

extension View {
    func bold(size: CGFloat) -> some View {
        modifier(BoldViewModifier(size: size))
    }
    
    func regular(size: CGFloat) -> some View {
        modifier(RegularViewModifier(size: size))
    }
}

