//
//  PresentToastViewModifier.swift
//  
//
//  Created by Jack Wong on 2/19/21.
//

import SwiftUI

#if os(iOS)
struct PresentToastViewModifier<ToastContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let dismissAfter: Double?
    let onDismiss: (() -> Void)?
    let content: () -> ToastContent

    @State private var keyWindow: UIWindow?

    private func present() {
      if keyWindow == nil {
        keyWindow = UIApplication.shared.windows.first(where: \.isKeyWindow)
      }
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

      let toastAlreadyPresented = rootViewController is ToastHostingController<ToastContent>

      if isPresented {
        if !toastAlreadyPresented {
          let toastViewController = ToastHostingController(rootView: content())
          rootViewController?.present(toastViewController, animated: true)

          if let dismissAfter = dismissAfter {
            DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) {
              isPresented = false
            }
          }
        }
      } else {
        if toastAlreadyPresented {
          rootViewController?.dismiss(animated: true, completion: onDismiss)
        }
        keyWindow = nil
      }
    }

    func body(content: Content) -> some View {
      content
        .onChange(of: isPresented) { _ in
          present()
        }
    }
}
#endif
