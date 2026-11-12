import Foundation

// One country from the REST Countries v5 API.
//
// Codable: Swift can build this struct from JSON automatically (decoding).
// Identifiable: List and ForEach need a unique `id` for each item.
// Hashable: lets us use a Country as a NavigationLink value.
//
// Most properties are Optionals (`?`) because some territories leave fields out.
// For example, Antarctica has no capital. With Optionals, a missing field becomes
// nil instead of making the whole download fail.
struct Country: Codable, Identifiable, Hashable {
    let names: Names
    let codes: Codes
    let capitals: [Capital]?
    let flag: Flag?
    let region: String?
    let subregion: String?
    let population: Int?
    let languages: [Language]?
    let currencies: [Currency]?

    // The 2-letter code (like "FR") is unique, so we use it as the id.
    var id: String { codes.alpha2 ?? names.common }

    // MARK: - Nested types (small pieces of the JSON)

    struct Names: Codable, Hashable {
        let common: String          // "France"
        let official: String?       // "French Republic"
    }

    struct Codes: Codable, Hashable {
        let alpha2: String?         // "FR"

        // CodingKeys: the JSON says "alpha_2", but Swift names use camelCase.
        enum CodingKeys: String, CodingKey {
            case alpha2 = "alpha_2"
        }
    }

    struct Capital: Codable, Hashable {
        let name: String
        let primary: Bool?
    }

    struct Flag: Codable, Hashable {
        let emoji: String?
        let urlPNG: String?

        enum CodingKeys: String, CodingKey {
            case emoji
            case urlPNG = "url_png"
        }
    }

    struct Language: Codable, Hashable {
        let name: String
    }

    struct Currency: Codable, Hashable {
        let code: String            // "EUR"
        let name: String?           // "Euro"
        let symbol: String?         // "€"
    }

    // MARK: - Computed properties (handy values for the views)

    var name: String { names.common }

    var officialName: String { names.official ?? names.common }

    // Use the capital marked "primary", or the first one if none is marked.
    var capital: String {
        let main = capitals?.first { $0.primary == true } ?? capitals?.first
        return main?.name ?? "No capital"
    }

    var flagURL: URL? {
        guard let text = flag?.urlPNG else { return nil }
        return URL(string: text)
    }

    // The first currency is the main one (some countries list several).
    var mainCurrency: Currency? { currencies?.first }

    var languageList: String {
        let names = (languages ?? []).map { $0.name }
        return names.isEmpty ? "Unknown" : names.joined(separator: ", ")
    }

    // 67935660 → "67,935,660" (uses the phone's number style)
    var formattedPopulation: String {
        guard let population else { return "Unknown" }
        return population.formatted()
    }
}
