//
//  ModifierExt.swift
//  Foody
//
//  Created by An Nguyễn on 4/5/21.
//

import SwiftUI
import Combine

struct BackBarModifier: ViewModifier {
    var action: (()-> Void)?
    var color: Color
    var navigationBarHidden: Bool
    
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
            
            HStack {
                BackButton(action: action)
                    .foregroundColor(color)
                    .background(
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color.gray.opacity(0.4))
                    )
                Spacer()
            }
            .padding(.horizontal, 15)
            .padding(.top, 15)
        }
        .navigationBarHidden(navigationBarHidden)
    }
}

extension View {
    func addBackBarCustom(_ color: Color = .white, barHidden: Bool = true,
                          action: (()-> Void)? = nil) -> some View {
        self.modifier(BackBarModifier(action: action, color: color, navigationBarHidden: barHidden))
    }
}


struct HandleKeyboardModifier: ViewModifier {
    var hiddenAction: () -> Void
    
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
                .onTapGesture {
                    hiddenAction()
                }
        }
    }
}

extension View {
    func handleHidenKeyboard() -> some View {
        self.modifier(
            HandleKeyboardModifier(hiddenAction: {
                hideKeyboard()
            })
        )
    }
}


// Keyboard
struct KeyboardAwareModifier: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0

    private var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue }
                .map { $0.cgRectValue.height },
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in CGFloat(0) }
       ).eraseToAnyPublisher()
    }

    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .onReceive(keyboardHeightPublisher) { self.keyboardHeight = $0 }
    }
}

extension View {
    func keyboardAwarePadding() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAwareModifier())
    }
}


//TODO:- Padding

struct PaddingModifier: ViewModifier {
    var edge: Edge.Set
    
    func content() {
        
    }
    
    func body(content: Content) -> some View {
        content
            .padding([.trailing, .all], 10)
    }
}

// Add loading view
extension View {
    func addLoadingIcon(_ isLoading: Binding<Bool>) -> some View {
        ZStack {
            self
            
            if isLoading.wrappedValue {
                IndefiniteProgressView()
                    .animation(.easeInOut)
            }
        }
    }
    
    func handleErrors(_ error: Binding<CommonError?>) -> some View {
        self
            .present(item: error, content: {
                AlertView($0)
            })
    }
    
    func handleShowPupup(with content: Binding<PopupContent?>) -> some View {
        self
            .present(item: content, content: {
                AlertView($0)
            })
    }
}

// Refresh Scroll
extension ScrollView {
    func onRefresh(_ onRefresh: @escaping () -> Void) -> some View {
        modifier(RefreshScrollModifier(onRefresh))
    }
}

struct RefreshScrollModifier: ViewModifier {
    let coordinator: Coodinator
    
    init(_ action: (() -> Void)? = nil) {
        coordinator = Coodinator(action)
    }
    
    func body(content: Content) -> some View {
        content
            .introspectScrollView { (scrollView) in
                let refreshControl = UIRefreshControl()
                refreshControl.tintColor = .black
                refreshControl.addTarget(coordinator, action: #selector(coordinator.onRefresh(_:)), for: .valueChanged)
                scrollView.refreshControl = refreshControl
            }
    }
    
    class Coodinator: NSObject {
        var action: (() -> Void)?
        
        init(_ action: (() -> Void)? = nil) {
            self.action = action
        }
        
        @objc func onRefresh(_ refreshControl: UIRefreshControl) {
            action?()
            refreshControl.endRefreshing()
        }
        
    }
}
