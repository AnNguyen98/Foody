//
//  View.swift
//  Foody
//
//  Created by MBA0283F on 4/23/21.
//

import SwiftUI
import SwiftUIX

extension View {
    var rootViewController: UIViewController? {
        UIApplication.shared.rootViewController
    }

    var keyWindow: UIWindow? {
        UIApplication.shared.windows.first(where: \.isKeyWindow)
    }
    
    var topController: UIViewController? {
        var rootViewController = keyWindow?.rootViewController
        while true {
          if let presented = rootViewController?.presentedViewController {
            rootViewController = presented
          } else if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.visibleViewController
          } else if let tabBarController = rootViewController as? UITabBarController {
            rootViewController = tabBarController.selectedViewController
          } else {
            break
          }
        }
        UINavigationController().interactivePopGestureRecognizer?.isEnabled = true
        return rootViewController
    }
    
    func makeRoot(_ status: SceneDelegate.Status) {
        let hostingController = HostingController(rootView: status.contentView) // Status.logged.contentView)
        keyWindow?.rootViewController = hostingController
        UIApplication.hostingController = hostingController
    }
    
    ///Dismisses the view controller that was presented modally by the view controller.
    func dismiss() {
        topController?.dismiss(animated: true)
    }
    
    func presentView<T: View>(_ view: T, transitionStyle: UIModalTransitionStyle = .crossDissolve) {
        let view = view.statusBarStyle(.lightContent)
        let alertVC = HostingController(rootView: view)
        alertVC.modalTransitionStyle = transitionStyle
        alertVC.modalPresentationStyle = .overCurrentContext
        alertVC.view.backgroundColor = .clear
        topController?.present(alertVC, animated: true)
    }
    
    func present<Item: Identifiable>(item: Binding<Item?>, content: (Binding<Item?>) -> AlertView<Item>) -> some View {
        if let _ = item.wrappedValue {
            presentView(content(item))
        }
        return self
    }
    
    func handleAction(isActive: Binding<Bool>, action: () -> Void) -> some View {
        if isActive.wrappedValue {
            action()
        }
        return self
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

extension View {
    // Set background ignoresSafeArea, should be in last of view
    func setupBackgroundNavigationBar(_ color: Color = Colors.redColorCustom) -> some View {
        ZStack {
            color
                .ignoresSafeArea()
            
            self
                .background(Color.white)
        }
    }
}

extension View {
    /// Setup font, color for title navigation
    func setupNavigationBar(titleSize: CGFloat = 20, largeTitleSize: CGFloat = 34, titleCOlor: UIColor = .white) -> some View {
        self
            .onAppear(perform: {
                UINavigationBar.appearance().tintColor = .white
                let coloredAppearance = UINavigationBarAppearance()
                coloredAppearance.configureWithOpaqueBackground()
                coloredAppearance.backgroundColor = Colors.redColorCustom.toUIColor
                coloredAppearance.titleTextAttributes = [
                    .font: UIFont.boldSystemFont(ofSize: titleSize),
                    .foregroundColor: titleCOlor
                ]
                coloredAppearance.largeTitleTextAttributes = [
                    .font: UIFont.boldSystemFont(ofSize: largeTitleSize),
                    .foregroundColor: titleCOlor
                ]
                       
                UINavigationBar.appearance().standardAppearance = coloredAppearance
                UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
                
                UINavigationBar.appearance().barTintColor = Colors.redColorCustom.toUIColor
            })
            .statusBarStyle(.lightContent)
    }
}

extension View {
    var toAnyView: AnyView {
        AnyView(self)
    }
}

// Prepare For LoadMore
extension View {
    var defaultGridItemLayout: [GridItem] {
        Array(repeating: GridItem(.fixed((kScreenSize.width - 30 - 15) / 2) , spacing: 15), count: 2)
    }
    
    func prepareForLoadMore(loadMore: @escaping () -> Void, showIndicator: Bool) -> some View {
        ScrollView {
            self
                .padding([.horizontal, .top])

            if showIndicator {
                ActivityIndicator()
                    .style(.regular)
                    .tintColor(.black)
                    .onAppear {
                        loadMore()
                    }
                    .padding(.bottom, 8)
            }
        }
    }
}

extension View {
    func border(cornerRadius: CGFloat = 0, borderColor: Color = .gray, lineWidth: CGFloat = 1) -> some View {
        self
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: lineWidth)
            )
    }
}
