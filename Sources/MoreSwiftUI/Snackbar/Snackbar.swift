//
//  SwiftUIView.swift
//  
//
//  Created by Jack Wong on 3/4/21.
//

import SwiftUI

public struct SnackbarModifier<Item: Identifiable, Banner: View>: ViewModifier {
    @Binding var data: Item?
    
    private let contentProvider: (Item) -> Banner
    
    init(data: Binding<Item?>, @ViewBuilder contentProvider: @escaping (Item) -> Banner) {
        _data = data
        self.contentProvider = contentProvider
    }
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content
            data.map(contentProvider)
                .transition(AnyTransition.move(edge: .bottom).combined(with:.opacity))
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
    /// Presents a snackbar to the user.
    ///
    /// - Parameters:
    ///   - item: A binding to an optional source of truth for the alert.
    ///     When representing a non-`nil` item, the system uses `content` to
    ///     create a snackbar representation of the item.
    ///     If the identity changes, the system dismisses a
    ///     currently-presented snackbar and replace it by a new banner.
    ///   - content: A closure returning the snackbar to present.
    func snackbar<Item, Content: View>(item: Binding<Item?>, content: @escaping (Item) -> Content) -> some View where Item : Identifiable {
        modifier(SnackbarModifier(data: item, contentProvider: content))
    }
}

