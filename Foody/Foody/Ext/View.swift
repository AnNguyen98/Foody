//
//  View.swift
//  Foody
//
//  Created by MBA0283F on 4/23/21.
//

import SwiftUI

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

