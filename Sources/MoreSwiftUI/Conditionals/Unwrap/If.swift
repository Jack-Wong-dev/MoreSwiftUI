//
//  SwiftUIView.swift
//  
//
//  Created by Jack Wong on 1/31/21.
//

import SwiftUI

public struct If<IfContent: View, ElseContent: View>: View {
    
    public let condition: Bool
    public let contentIfTrue: () -> IfContent
    public let contentIfFalse: () -> ElseContent
    
    public init(_ condition: Bool, @ViewBuilder content contentIfTrue: @escaping () -> IfContent, else contentIfFalse: @escaping () -> ElseContent) {
        self.condition = condition
        self.contentIfTrue = contentIfTrue
        self.contentIfFalse = contentIfFalse
    }
    
    public var body: some View {
        if condition {
            IfContent?.some(contentIfTrue())
        } else {
            ElseContent?.some(contentIfFalse())
        }
    }
}
