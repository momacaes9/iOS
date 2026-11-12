import Foundation

// Talks to the free Frankfurter exchange-rate API (no key needed).
enum ExchangeService {
    static let baseURL = "https://api.frankfurter.dev/v1/latest"

    // Gets today's rates for one base currency, for example:
    //     let rates = try await ExchangeService.fetchRates(base: "USD")
    static func fetchRates(base: String) async throws -> ExchangeRates {
        guard var components = URLComponents(string: baseURL) else { throw APIError.invalidURL }
        components.queryItems = [URLQueryItem(name: "base", value: base)]
        guard let url = components.url else { throw APIError.invalidURL }

        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await URLSession.shared.data(from: url)
        } catch {
            throw APIError.network(error)
        }

        if let http = response as? HTTPURLResponse, http.statusCode != 200 {
            throw APIError.badStatus(http.statusCode)
        }

        do {
            return try JSONDecoder().decode(ExchangeRates.self, from: data)
        } catch {
            throw APIError.decodingFailed
        }
    }
}
