//
//  ToastHostingController.swift
//  
//
//  Created by Jack Wong on 2/19/21.
//

import SwiftUI

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
