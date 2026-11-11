import SwiftUI

// Shows the album cover in a square frame. If the image isn't in Assets yet,
// it shows a gray rounded rectangle with a music note instead.
struct AlbumArtView: View {
    let imageName: String

    var body: some View {
        // UIImage(named:) returns nil when the image can't be found,
        // so `if let` lets us check whether the asset exists.
        if let cover = UIImage(named: imageName) {
            // An invisible square sets the size, and the image is drawn on top of it.
            // This keeps the frame square even when the picture isn't.
            Color.clear
                .aspectRatio(1, contentMode: .fit)
                .overlay(
                    Image(uiImage: cover)
                        .resizable()         // let the image grow or shrink
                        .scaledToFill()      // fill the whole square (edges may be cut off)
                )
                .clipped()                   // cut off anything outside the square
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 20)
        } else {
            // Placeholder: a shape with an SF Symbol on top
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.4))
                .aspectRatio(1, contentMode: .fit)   // keep it square
                .overlay(
                    Image(systemName: "music.note")
                        .font(.system(size: 80))
                        .foregroundStyle(.white.opacity(0.6))
                )
                .shadow(radius: 20)
        }
    }
}

#Preview {
    AlbumArtView(imageName: "bohemian")
        .padding()
        .background(.black)
}
