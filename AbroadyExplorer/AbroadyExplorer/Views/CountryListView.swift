import SwiftUI

// The Explore tab: a searchable, filterable, sortable list of countries.
struct CountryListView: View {
    // Data passed in from ContentView
    let countries: [Country]
    let isLoading: Bool
    let errorMessage: String?
    let reload: () async -> Void        // a function we can call to download again

    // @State for the user's choices on this screen
    @State private var searchText = ""
    @State private var selectedRegion = "All"
    @State private var sortOption = SortOption.name

    let regions = ["All", "Africa", "Americas", "Asia", "Europe", "Oceania"]

    // The two ways to sort. An enum lists a fixed set of choices.
    // CaseIterable lets us loop over all cases with ForEach.
    enum SortOption: String, CaseIterable {
        case name = "Name"
        case population = "Population"
    }

    // A computed property: search → filter by region → sort.
    // It runs again every time searchText, selectedRegion or sortOption changes.
    var visibleCountries: [Country] {
        var result = countries

        if !searchText.isEmpty {
            result = result.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }

        if selectedRegion != "All" {
            result = result.filter { $0.region == selectedRegion }
        }

        switch sortOption {
        case .name:
            result.sort { $0.name < $1.name }
        case .population:
            result.sort { ($0.population ?? 0) > ($1.population ?? 0) }   // biggest first
        }
        return result
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Segmented Picker: tap a region to filter the list
                Picker("Region", selection: $selectedRegion) {
                    ForEach(regions, id: \.self) { region in
                        Text(region).tag(region)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.bottom, 8)

                content
            }
            .navigationTitle("Explore")
            // Says which screen to show for a tapped Country
            .navigationDestination(for: Country.self) { country in
                CountryDetailView(country: country)
            }
            // .searchable adds a search bar under the title and binds it to searchText
            .searchable(text: $searchText, prompt: "Search countries")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    // A Menu holding a Picker shows the sort choices in a pop-up list
                    Menu {
                        Picker("Sort by", selection: $sortOption) {
                            ForEach(SortOption.allCases, id: \.self) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down.circle")
                    }
                }
            }
        }
    }

    // @ViewBuilder lets this property return different views using if/else
    @ViewBuilder
    var content: some View {
        if isLoading && countries.isEmpty {
            LoadingView(message: "Loading countries…")
        } else if let errorMessage, countries.isEmpty {
            ErrorView(message: errorMessage, retry: reload)
        } else if visibleCountries.isEmpty {
            // Apple's built-in "No Results for …" screen
            ContentUnavailableView.search(text: searchText)
        } else {
            List {
                // ForEach + a reusable subview for each row
                ForEach(visibleCountries) { country in
                    // NavigationLink(value:) opens the detail screen when the row is tapped
                    NavigationLink(value: country) {
                        CountryRowView(country: country)
                    }
                }
            }
            .listStyle(.plain)
            // Pull down on the list to download the countries again
            .refreshable {
                await reload()
            }
        }
    }
}

#Preview {
    CountryListView(countries: Country.samples, isLoading: false, errorMessage: nil, reload: {})
}
