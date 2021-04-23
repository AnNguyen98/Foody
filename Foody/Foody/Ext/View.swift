//
//  View.swift
//  Foody
//
//  Created by MBA0283F on 4/23/21.
//

import SwiftUI

extension View {
    var rootViewController: UIViewController? {
        UIApplication.shared.windows.first?.rootViewController
    }
    
    var topController: UIViewController? {
        if var topVC = rootViewController {
            while let presentedViewController = topVC.presentedViewController {
                topVC = presentedViewController
            }
            return topVC
        }
        return nil
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
}