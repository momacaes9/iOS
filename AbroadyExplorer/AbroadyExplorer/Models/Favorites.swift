import Foundation

// Helpers for the saved favorites.
// @AppStorage can only save simple values (String, Int, Bool…), so we save the favorite
// country codes as one comma-separated String, like "FR,JP,BR".
enum Favorites {
    // The name the favorites are saved under on the phone
    static let storageKey = "favoriteCountryCodes"

    // "FR,JP" → ["FR", "JP"]
    static func codes(from stored: String) -> [String] {
        stored.split(separator: ",").map { String($0) }
    }

    // Adds a code (if it isn't already saved) and returns the new String
    static func adding(_ code: String, to stored: String) -> String {
        var list = codes(from: stored)
        if !list.contains(code) {
            list.append(code)
        }
        return list.joined(separator: ",")
    }

    // Removes a code and returns the new String
    static func removing(_ code: String, from stored: String) -> String {
        codes(from: stored)
            .filter { $0 != code }
            .joined(separator: ",")
    }
}
