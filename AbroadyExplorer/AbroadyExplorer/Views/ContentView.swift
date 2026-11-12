import SwiftUI

// The root of the app: a TabView with the Explore tab.
// ContentView owns the downloaded countries (@State), so every tab can share the same list.
struct ContentView: View {
    @State private var countries: [Country] = []
    @State private var isLoading = false
    @State private var errorMessage: String? = nil     // nil means "no error"

    var body: some View {
        TabView {
            Tab("Explore", systemImage: "globe.americas.fill") {
                CountryListView(countries: countries,
                                isLoading: isLoading,
                                errorMessage: errorMessage,
                                reload: loadCountries)
            }
        }
        // .task runs async code when the view first appears
        .task {
            await loadCountries()
        }
    }

    // Downloads all countries and updates the @State, which redraws the screen.
    func loadCountries() async {
        isLoading = true
        errorMessage = nil
        do {
            countries = try await CountryService.fetchCountries()
        } catch {
            // error.localizedDescription uses the friendly text from APIError
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}

#Preview {
    ContentView()
}
