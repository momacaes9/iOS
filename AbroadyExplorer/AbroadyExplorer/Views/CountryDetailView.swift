import SwiftUI

// Everything about one country: big flag, official name, facts and a favorite button.
struct CountryDetailView: View {
    let country: Country

    // @AppStorage saves a value on the phone, so favorites are still there after the app closes.
    @AppStorage(Favorites.storageKey) private var favoriteCodes = ""

    // The USD amount for the converter. It lives here, and the converter edits it with a @Binding.
    @State private var usdAmount = "100"

    // A custom Binding: it reads and writes favoriteCodes, but looks like a simple Bool
    // to FavoriteButton. `get` answers "is it saved?" and `set` saves or removes it.
    var isFavorite: Binding<Bool> {
        Binding(
            get: { Favorites.codes(from: favoriteCodes).contains(country.id) },
            set: { newValue in
                if newValue {
                    favoriteCodes = Favorites.adding(country.id, to: favoriteCodes)
                } else {
                    favoriteCodes = Favorites.removing(country.id, from: favoriteCodes)
                }
            }
        )
    }

    // The facts to show. Each item is (SF Symbol, title, value).
    var facts: [(icon: String, title: String, value: String)] {
        [
            ("building.columns", "Capital", country.capital),
            ("globe.europe.africa", "Region", country.region ?? "Unknown"),
            ("map", "Subregion", country.subregion ?? "Unknown"),
            ("person.3", "Population", country.formattedPopulation),
            ("character.bubble", "Languages", country.languageList),
            ("banknote", "Currency", currencyText)
        ]
    }

    // For example "Euro (€) · EUR"
    var currencyText: String {
        guard let currency = country.mainCurrency else { return "Unknown" }
        var text = currency.name ?? currency.code
        if let symbol = currency.symbol { text += " (\(symbol))" }
        return text + " · " + currency.code
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header card: flag, official name and region chips
                VStack(spacing: 14) {
                    FlagImageView(country: country, width: 240)
                        .shadow(color: .black.opacity(0.15), radius: 8, y: 4)

                    Text(country.officialName)
                        .font(.title2.bold())
                        .multilineTextAlignment(.center)

                    HStack {
                        // compactMap drops the nil values, so a missing subregion has no empty chip
                        ForEach([country.region, country.subregion].compactMap { $0 }, id: \.self) { place in
                            RegionChipView(region: place)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .cardStyle()

                // Facts card: one reusable InfoRowView per fact
                VStack(spacing: 0) {
                    ForEach(facts, id: \.title) { fact in
                        InfoRowView(icon: fact.icon, title: fact.title, value: fact.value)
                        if fact.title != facts.last?.title {
                            Divider()
                        }
                    }
                }
                .cardStyle()

                // Converter card. $usdAmount passes a Binding to our @State.
                CurrencyConverterView(currency: country.mainCurrency, amountText: $usdAmount)
                    .cardStyle()
            }
            .padding()
        }
        .scrollDismissesKeyboard(.interactively)    // drag down to hide the keyboard
        .background(Color(.systemGroupedBackground))
        .navigationTitle(country.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                // Pass the Binding with no $, because isFavorite is already a Binding
                FavoriteButton(isFavorite: isFavorite)
            }
        }
    }
}

// A reusable modifier for our rounded "card" look.
// `extension View` adds .cardStyle() to every view, just like .padding() or .font().
extension View {
    func cardStyle() -> some View {
        self
            .padding()
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    NavigationStack {
        CountryDetailView(country: .sampleFrance)
    }
}
