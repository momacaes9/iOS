import Foundation

// Everything that can go wrong when we talk to an API.
// LocalizedError lets each case give a friendly message we can show on screen.
enum APIError: LocalizedError {
    case missingKey                 // Secrets.swift still has the placeholder
    case invalidURL
    case unauthorized               // the server rejected our key (401 / 403)
    case badStatus(Int)             // any other non-200 HTTP status
    case decodingFailed             // the JSON didn't match our structs
    case network(Error)             // no internet, timeout, etc.

    var errorDescription: String? {
        switch self {
        case .missingKey:
            return "No REST Countries API key yet. Copy Secrets.example.swift to Secrets.swift and paste your key in it."
        case .invalidURL:
            return "The request address was not valid."
        case .unauthorized:
            return "The REST Countries API rejected the key. Check the key in Secrets.swift."
        case .badStatus(let code):
            return "The server answered with an error (HTTP \(code)). Please try again."
        case .decodingFailed:
            return "The data came back in an unexpected format."
        case .network:
            return "Couldn't reach the server. Check your internet connection and try again."
        }
    }
}
