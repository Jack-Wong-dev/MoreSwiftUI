//
//  SnackbarDemo.swift
//  MoreSwiftUISample (iOS)
//
//  Created by Jack Wong on 3/4/21.
//

import SwiftUI

struct SnackbarDemo: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var randomSnackbar: SnackbarContent?
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            VStack {
                Button(action: showRandomSnackBar) {
                    Text("Show random snackbar")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Button(action: dismiss) {
                Label("Go Back", systemImage: "chevron.left")
            }
            .padding()
        }
        .snackbar(item: $randomSnackbar) { snackbar in
            SnackBarExampleView(snackBar: snackbar)
        }
    }
    
    private func showRandomSnackBar() {
        withAnimation {
            randomSnackbar = SnackbarContent.allCases.randomElement()
        }
    }
    
    private func dismiss() {
        withAnimation {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

enum SnackbarContent: String, Identifiable, CaseIterable {
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

struct SnackBarExampleView: View {
    var snackBar: SnackbarContent
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(snackBar.id)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
        }
        .padding()
        .background(
            Color(snackBar.color)
                .ignoresSafeArea()
        )
    }
}

struct SnackbarDemo_Previews: PreviewProvider {
    static var previews: some View {
        SnackbarDemo()
    }
}
