import Foundation

// Exchange rates from the Frankfurter API, for example:
// { "amount": 1.0, "base": "USD", "date": "2026-11-12", "rates": { "EUR": 0.90245, "JPY": 159.7 } }
// The JSON names already match our Swift names, so we don't need CodingKeys here.
struct ExchangeRates: Codable {
    let amount: Double
    let base: String
    let date: String
    let rates: [String: Double]     // a Dictionary: currency code → rate

    // How many units of `code` you get for 1 unit of the base currency.
    // Returns nil when Frankfurter doesn't support that currency.
    func rate(for code: String) -> Double? {
        if code == base { return 1 }    // USD → USD is always 1
        return rates[code]
    }
}
