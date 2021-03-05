//
//  SelectionButtonStyle.swift
//  MoreSwiftUISample (iOS)
//
//  Created by Jack Wong on 3/4/21.
//

import SwiftUI

struct SelectionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 12)
            .padding(16)
            .background(
                Capsule()
                    .foregroundColor(Color.white)
                    .shadow(color: Color(.black).opacity(0.16), radius: 12, x: 0, y: 5)
            )
            .scaleEffect(configuration.isPressed ? 0.7 : 1)
            .animation(.default)
    }
}
