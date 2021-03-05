//
//  ContentView.swift
//  Shared
//
//  Created by Jack Wong on 3/4/21.
//

import SwiftUI
import MoreSwiftUI

enum ModalType : Identifiable, CaseIterable, View {
    case banner
    case toast
    case snackbar
    
    var id: String {
        switch self {
        case .banner:
            return "Banner"
        case .toast:
            return "Toast"
        case .snackbar:
            return "Snackbar"
        }
    }
    
    var body: some View {
        switch self {
        case .banner:
            BannerDemo()
        case .toast:
            ToastDemo()
        case .snackbar:
            SnackbarDemo()
        }
    }
}

struct OptionButton: View {
    @Binding var example: ModalType?
    let option: ModalType
    
    var body: some View {
        Button(action: action) {
            Text("Go to \(option.id) example")
        }
    }
    
    private func action() {
        withAnimation {
            example = option
        }
    }
}

struct ContentView: View {
    @State private var example: ModalType?
    
    var body: some View {
        NavigationView {
            VStack {
                ForEach(ModalType.allCases) {
                    OptionButton(example: $example, option: $0)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .fullScreenCover(item: $example) {
                $0.buttonStyle(SelectionButtonStyle())
            }
            .navigationTitle("MoreSwiftUI Demos")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func showBannerDemo() {
        withAnimation {
            example = .banner
        }
    }
    
    private func showToastDemo() {
        withAnimation {
            example = .toast
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
