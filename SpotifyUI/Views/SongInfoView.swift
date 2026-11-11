import SwiftUI

// Song title and artist on the left, heart button on the right.
struct SongInfoView: View {
    let title: String
    let artist: String

    // @Binding means this view doesn't own the data. It reads and writes
    // the @State that lives in ContentView.
    @Binding var isLiked: Bool

    var body: some View {
        // HStack puts its children side by side (horizontally).
        HStack {
            // alignment: .leading lines the text up on the left edge
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.white)
                Text(artist)
                    .font(.body)
                    .foregroundStyle(.white.opacity(0.7))
            }

            Spacer()   // pushes the heart all the way to the right

            Button {
                isLiked.toggle()   // toggle() flips true <-> false
            } label: {
                // Ternary operator: condition ? valueIfTrue : valueIfFalse
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .font(.title2)
                    .foregroundStyle(isLiked ? .green : .white)
            }
        }
    }
}

#Preview {
    SongInfoView(title: "Bohemian Rhapsody", artist: "Queen", isLiked: .constant(true))
        .padding()
        .background(.black)
}
