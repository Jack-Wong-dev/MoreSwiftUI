//
//  SwiftUIView.swift
//  
//
//  Created by Jack Wong on 3/4/21.
//

import SwiftUI

public struct ToastModifier<Item: Identifiable, Banner: View>: ViewModifier {
    @Binding var data: Item?
    private let contentProvider: (Item) -> Banner
    
    init(data: Binding<Item?>, @ViewBuilder contentProvider: @escaping (Item) -> Banner) {
        _data = data
        self.contentProvider = contentProvider
    }
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            content
            data.map(contentProvider)
                .transition(AnyTransition.identity.combined(with:.opacity))
//                                .onTapGesture {
//                                    withAnimation {
//                                        data = nil
//                                    }
//                                }
                .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            data = nil
                        }
                    }
                })
                .zIndex(1)
        }
    }
}

public extension View {
    /// Presents a toast  to the user.
    ///
    /// - Parameters:
    ///   - item: A binding to an optional source of truth for the toast.
    ///     When representing a non-`nil` item, the system uses `content` to
    ///     create a toast representation of the item.
    ///     If the identity changes, the system dismisses a
    ///     currently-presented toast and replace it by a new toast.
    ///   - content: A closure returning the toast to present.
    func toast<Item, Content: View>(item: Binding<Item?>, content: @escaping (Item) -> Content) -> some View where Item : Identifiable {
        modifier(ToastModifier(data: item, contentProvider: content))
    }
}
