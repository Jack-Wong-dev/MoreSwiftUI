//
//  ToastDemo.swift
//  MoreSwiftUISample (iOS)
//
//  Created by Jack Wong on 3/4/21.
//

import SwiftUI

struct ToastDemo: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var randomBanner: ToastContent?
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            VStack {
                Button(action: showRandomToast) {
                    Text("Show random toast")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Button(action: dismiss) {
                Label("Go Back", systemImage: "chevron.left")
            }
            .padding()
        }
        .toast(item: $randomBanner) { toast in
            ToastExampleView(toast: toast)
        }
    }
    
    private func showRandomToast() {
        withAnimation {
            randomBanner = ToastContent.allCases.randomElement()
        }
    }
    
    private func dismiss() {
        withAnimation {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

enum ToastContent: String, Identifiable, CaseIterable {
    var id: String { self.rawValue.capitalized }
    
    case warning
    case success
    case error
    
    var color: UIColor {
        switch self {
        case .warning:
            return .systemYellow
        case .success:
        return .systemGreen
        case .error:
            return .systemRed
        }
    }
}

struct ToastExampleView: View {
    var toast: ToastContent
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(toast.id)
                .foregroundColor(.white)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color(toast.color))
        )
        .padding()
    }
}


struct ToastDemo_Previews: PreviewProvider {
    static var previews: some View {
        ToastDemo()
    }
}
