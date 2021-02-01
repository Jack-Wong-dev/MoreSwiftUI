//
//  Unwrap.swift
//  
//
//  Created by Jack Wong on 1/31/21.
//

import SwiftUI

/// Presents a banner  to the user.
///
/// - Parameters:
///   - value: An optional item to unwrap.
///     When representing a non-`nil` item, the system uses `contentProvider` to
///     create a visual representation of the item.
///   - contentProvider: A closure returning the unwrapped value and its visual representation.
public struct Unwrap<Value, Content: View>: View {
    private let value: Value?
    private let contentProvider: (Value) -> Content
    
    public init(_ value: Value?,
         @ViewBuilder content: @escaping (Value) -> Content) {
        self.value = value
        self.contentProvider = content
    }
    
    public var body: some View {
        value.map(contentProvider)
    }
}
