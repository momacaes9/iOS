import Foundation

// One row in the 10-day forecast.
struct Day: Identifiable {
    let id = UUID()
    let name: String        // e.g. "Today", "Wed"
    let symbol: String      // SF Symbol name
    let low: Int
    let high: Int
}

extension Day {
    // The coldest and warmest temperatures the whole week can have.
    // The temperature bars are drawn relative to this range.
    static let weekLow = 48
    static let weekHigh = 78

    static let dayNames = ["Today", "Wed", "Thu", "Fri", "Sat", "Sun", "Mon", "Tue", "Wed", "Thu"]
    static let symbols = ["sun.max.fill", "cloud.sun.fill", "cloud.rain.fill", "cloud.bolt.rain.fill",
                          "sun.max.fill", "cloud.fill", "cloud.sun.fill", "cloud.drizzle.fill",
                          "sun.max.fill", "cloud.sun.fill"]

    // Builds 10 days with a random low and high inside the week's range.
    // `map` runs the code once for each number 0...9 and collects the results in an array.
    static func makeSampleData() -> [Day] {
        (0..<10).map { index in
            let low = Int.random(in: weekLow...(weekHigh - 10))     // leave room for the high
            let high = Int.random(in: (low + 6)...weekHigh)         // high is always above low
            return Day(name: dayNames[index], symbol: symbols[index], low: low, high: high)
        }
    }
}
