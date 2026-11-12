import Foundation

// Talks to the REST Countries v5 API.
//
// The method is `static`, so we call it on the type itself without making an object:
//     let countries = try await CountryService.fetchCountries()
// `async` means it waits for the network without freezing the screen.
// `throws` means it can fail, so callers use `try` inside a do/catch.
enum CountryService {
    static let baseURL = "https://api.restcountries.com/countries/v5"

    // Only ask for the fields the app shows. This keeps each download small.
    static let fields = [
        "names.common", "names.official", "codes.alpha_2", "capitals", "flag",
        "region", "subregion", "population", "languages", "currencies"
    ].joined(separator: ",")

    // Downloads every country, one page of 100 at a time, until the API says there are no more.
    static func fetchCountries() async throws -> [Country] {
        let key = Secrets.restCountriesKey
        if key.isEmpty || key.hasPrefix("YOUR_") {
            throw APIError.missingKey
        }

        var allCountries: [Country] = []
        var offset = 0
        let pageSize = 100

        // `while true` keeps going until we `break` out of the loop
        while true {
            let page = try await fetchPage(offset: offset, limit: pageSize, key: key)
            allCountries += page.data.objects

            // Stop when there are no more pages (or the page came back empty, just in case)
            let hasMore = page.data.meta?.more ?? false
            if !hasMore || page.data.objects.isEmpty { break }
            offset += pageSize
        }
        return allCountries
    }

    // Downloads one page of countries.
    private static func fetchPage(offset: Int, limit: Int, key: String) async throws -> CountryListResponse {
        // URLComponents builds a URL and safely adds the ?query=parameters
        guard var components = URLComponents(string: baseURL) else { throw APIError.invalidURL }
        components.queryItems = [
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "offset", value: String(offset)),
            URLQueryItem(name: "response_fields", value: fields)
        ]
        guard let url = components.url else { throw APIError.invalidURL }

        // A URLRequest lets us add headers. This API needs our key as a Bearer token.
        var request = URLRequest(url: url)
        request.setValue("Bearer \(key)", forHTTPHeaderField: "Authorization")

        // `await` pauses here until the data arrives
        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            throw APIError.network(error)
        }

        // Check the HTTP status code (200 means OK)
        if let http = response as? HTTPURLResponse {
            if http.statusCode == 401 || http.statusCode == 403 { throw APIError.unauthorized }
            if http.statusCode != 200 { throw APIError.badStatus(http.statusCode) }
        }

        do {
            return try JSONDecoder().decode(CountryListResponse.self, from: data)
        } catch {
            print("Country decoding error: \(error)")   // shows the details in Xcode's console
            throw APIError.decodingFailed
        }
    }
}
