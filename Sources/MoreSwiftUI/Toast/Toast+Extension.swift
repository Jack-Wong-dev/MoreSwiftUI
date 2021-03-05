////
////  Toast+Extension.swift
////  
////
////  Created by Jack Wong on 2/19/21.
////
//
//import SwiftUI
//
//public extension View {
//    /// Presents a toast to the user.
//    ///
//    /// - Parameters:
//    ///   - isPresented: A binding to a Boolean value that determines whether to present the toast.
//    ///   - dismissAfter: Time it takes to dismiss a toast when representing a non-`nil` value.  By default it is set to 2 seconds.
//    ///   - onDismiss: The closure to execute when dismissing the toast.
//    ///   - content: A closure that returns the content of the toast..
//    func toast<Content: View>(
//        isPresented: Binding<Bool>,
//        dismissAfter: Double? = 2,
//        onDismiss: (() -> Void)? = nil,
//        @ViewBuilder content: @escaping () -> Content
//    ) -> some View {
//        modifier(
//            PresentToastViewModifier<Content>(
//                isPresented: isPresented,
//                dismissAfter: dismissAfter,
//                onDismiss: onDismiss, content: content
//            )
//        )
//    }
// }
