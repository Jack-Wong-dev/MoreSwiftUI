//
//  MoreSwiftUISample (iOS)
//
//  Created by Jack Wong on 3/4/21.
//

import SwiftUI

struct BannerDemo: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var randomBanner: BannerContent?
    @ScaledMetric private var size: CGFloat = 24
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            VStack {
                Button(action:  showRandomBanner) {
                    Text("Show random banner")
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Button(action: dismiss) {
                Label("Go Back", systemImage: "chevron.left")
            }
            .padding()
        }
        .banner(item: $randomBanner) { banner in
            BannerExampleView(banner: banner)
        }
    }
    
    private func showRandomBanner() {
        withAnimation {
            randomBanner = BannerContent.allCases.randomElement()
        }
    }
    
    private func dismiss() {
        withAnimation {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct BannerDemo_Previews: PreviewProvider {
    static var previews: some View {
        BannerDemo()
    }
}

enum BannerContent: String, Identifiable, CaseIterable {
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

struct BannerExampleView: View {
    var banner: BannerContent
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(banner.id)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(banner.color))
        )
        .padding()
    }
}

