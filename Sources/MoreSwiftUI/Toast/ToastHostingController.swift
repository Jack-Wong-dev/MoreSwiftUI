//
//  ToastHostingController.swift
//  
//
//  Created by Jack Wong on 2/19/21.
//

import SwiftUI

//MARK: - iOS
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

//MARK: - MacOS
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
