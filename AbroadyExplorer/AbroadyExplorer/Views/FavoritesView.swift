import SwiftUI

// The Favorites tab: the countries you saved with the heart button.
struct FavoritesView: View {
    let countries: [Country]        // all countries, passed in from ContentView
    let isLoading: Bool

    // The same saved value CountryDetailView writes to, so both screens stay in sync
    @AppStorage(Favorites.storageKey) private var favoriteCodes = ""

    // Keep only the countries whose code is saved, in alphabetical order
    var favorites: [Country] {
        let codes = Favorites.codes(from: favoriteCodes)
        return countries
            .filter { codes.contains($0.id) }
            .sorted { $0.name < $1.name }
    }

    var body: some View {
        NavigationStack {
            Group {
                if isLoading && countries.isEmpty {
                    LoadingView(message: "Loading favorites…")
                } else if favorites.isEmpty {
                    // Empty state
                    ContentUnavailableView("No Favorites Yet",
                                           systemImage: "heart",
                                           description: Text("Tap the heart on a country to save it here."))
                } else {
                    List {
                        ForEach(favorites) { country in
                            NavigationLink(value: country) {
                                CountryRowView(country: country)
                            }
                        }
                        // Swipe left on a row to remove it from favorites
                        .onDelete { offsets in
                            for index in offsets {
                                favoriteCodes = Favorites.removing(favorites[index].id, from: favoriteCodes)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Favorites")
            .navigationDestination(for: Country.self) { country in
                CountryDetailView(country: country)
            }
        }
    }
}

#Preview {
    FavoritesView(countries: Country.samples, isLoading: false)
}
