//
//  Banner.swift
//  
//
//  Created by Jack Wong on 1/31/21.
//

import SwiftUI

public struct BannerViewModifier<Item: Identifiable, Banner: View>: ViewModifier {
    
    @Binding var data: Item?
    
//    var dissmissAfter: Double?
    
    private let contentProvider: (Item) -> Banner
    
//    init(data: Binding<Item?>, dismissAfter: Double? = 3.0, @ViewBuilder contentProvider: @escaping (Item) -> Banner) {
//        _data = data
//        self.dissmissAfter = dismissAfter
//        self.contentProvider = contentProvider
//    }
    
    init(data: Binding<Item?>, @ViewBuilder contentProvider: @escaping (Item) -> Banner) {
        _data = data
        self.contentProvider = contentProvider
    }
    
    public func body(content: Content) -> some View {
         ZStack(alignment: .top) {
            content
            data.map(contentProvider)
                .transition(AnyTransition.move(edge: .top).combined(with:.opacity))
                .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            data = nil
                        }
                    }
                })
                .onDisappear(perform: {
                    
                })
                .zIndex(1)
        }
    }
}

public extension View {
    /// Presents a banner  to the user.
    ///
    /// - Parameters:
    ///   - item: A binding to an optional source of truth for the alert.
    ///     When representing a non-`nil` item, the system uses `content` to
    ///     create a banner representation of the item.
    ///     If the identity changes, the system dismisses a
    ///     currently-presented banner and replace it by a new banner.
    ///   - content: A closure returning the banner to present.
    func banner<Item, Content: View>(item: Binding<Item?>, content: @escaping (Item) -> Content) -> some View where Item : Identifiable {
        modifier(BannerViewModifier(data: item, contentProvider: content))
    }
    
    
}


