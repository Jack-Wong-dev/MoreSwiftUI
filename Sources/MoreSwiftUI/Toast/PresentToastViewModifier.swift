//
//  PresentToastViewModifier.swift
//  
//
//  Created by Jack Wong on 2/19/21.
//

import SwiftUI

//MARK: iOS
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

//MARK: MacOS
#if os(macOS)
struct ToastViewIsPresentedModifier<ToastContent: View>: ViewModifier  {
  @Binding var isPresented: Bool
  let dismissAfter: Double?
  let onDismiss: (() -> Void)?
  let content: () -> ToastContent

  @State private var keyWindow: NSWindow?

  private func present() {
    if keyWindow == nil {
      keyWindow = NSApplication.shared.windows.first(where: \.isKeyWindow)
    }
    let rootViewController = keyWindow?.contentViewController
    let presentingToastViewController = rootViewController?.presentedViewControllers?
      .first(where: { $0 is ToastHostingController<QTContent> })
    let toastAlreadyPresented = presentingToastViewController != nil

    if isPresented {
      if !toastAlreadyPresented {
        let toastViewController = ToastHostingController(rootView: content())
        rootViewController?.presentAsSheet(toastViewController)

        if let dismissAfter = dismissAfter {
          DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) {
            isPresented = false
          }
        }
      }
    } else {
      if toastAlreadyPresented {
        (presentingToastViewController as? ToastHostingController<ToastContent>)?
          .dismissWithCompletion(onDismiss)
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

#if os(iOS)
final class ToastHostingController<Content: View>: UIHostingController<Content> {
    
    override init(rootView: Content) {
        super.init(rootView: rootView)
        setUp()
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        view.backgroundColor = .clear
    }
}
#endif

#if os(macOS)
final class ToastHostingController<Content: View>: NSHostingController<Content>, NSWindowDelegate {

    var onDismiss: (() -> Void)?

    override func viewDidAppear() {
      super.viewDidAppear()
      NSApplication.shared.windows.first?.delegate = self
    }

    func dismissWithCompletion(_ onDismiss: (() -> Void)? = nil) {
      self.onDismiss = onDismiss
      dismiss(nil)
    }

    func windowDidEndSheet(_ notification: Notification) {
      onDismiss?()
    }
}
#endif
