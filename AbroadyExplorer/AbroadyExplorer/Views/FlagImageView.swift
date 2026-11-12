import SwiftUI

// A country's flag downloaded from the internet.
// AsyncImage loads an image from a URL by itself and shows a placeholder while it waits.
// Both the row and the detail screen use this view, so the flag code lives in one place.
struct FlagImageView: View {
    let country: Country
    let width: CGFloat

    var body: some View {
        AsyncImage(url: country.flagURL) { image in
            // Shown once the image has downloaded
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            // Shown while loading, or if the country has no flag URL
            ZStack {
                Color.secondary.opacity(0.15)
                Text(country.flag?.emoji ?? "🏳️")
                    .font(.system(size: width * 0.4))
            }
        }
        // Flags are about 3:2, so the height is 2/3 of the width
        .frame(width: width, height: width * 2 / 3)
        .clipShape(RoundedRectangle(cornerRadius: width / 10))
        .overlay(
            // A thin border so white flags (like Japan's) don't blend into the background
            RoundedRectangle(cornerRadius: width / 10)
                .stroke(Color.secondary.opacity(0.25), lineWidth: 0.5)
        )
    }
}

#Preview {
    FlagImageView(country: .sampleJapan, width: 200)
}
