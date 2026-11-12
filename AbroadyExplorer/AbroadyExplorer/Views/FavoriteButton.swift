import SwiftUI

// A heart button that saves or un-saves a country.
// @Binding: the button doesn't own isFavorite. It changes a value that belongs to its parent
// (CountryDetailView), and the parent saves it with @AppStorage.
struct FavoriteButton: View {
    @Binding var isFavorite: Bool

    var body: some View {
        Button {
            isFavorite.toggle()
        } label: {
            // Ternary operator: a filled pink heart when saved, an outline when not
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundStyle(isFavorite ? .pink : .primary)
                // Animates the icon change with a little bounce
                .contentTransition(.symbolEffect(.replace))
        }
        .accessibilityLabel(isFavorite ? "Remove from favorites" : "Add to favorites")
    }
}

#Preview {
    @Previewable @State var isFavorite = true
    FavoriteButton(isFavorite: $isFavorite)
        .font(.largeTitle)
}
