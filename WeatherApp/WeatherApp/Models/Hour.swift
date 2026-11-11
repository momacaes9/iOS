import Foundation

// A struct groups related data together.
// Each Hour is one column in the hourly forecast.
// `Identifiable` means every Hour has a unique `id`, which lets ForEach tell the items apart.
struct Hour: Identifiable {
    let id = UUID()
    let time: String        // e.g. "Now", "2PM"
    let symbol: String      // SF Symbol name for the weather icon
    let temperature: Int    // degrees Fahrenheit
}

// Hardcoded sample data for Chapel Hill.
// `static` means it belongs to the Hour type itself, so we can write Hour.sampleData.
extension Hour {
    static let sampleData: [Hour] = [
        Hour(time: "Now", symbol: "sun.max.fill",        temperature: 68),
        Hour(time: "2PM", symbol: "sun.max.fill",        temperature: 70),
        Hour(time: "3PM", symbol: "cloud.sun.fill",      temperature: 71),
        Hour(time: "4PM", symbol: "cloud.sun.fill",      temperature: 71),
        Hour(time: "5PM", symbol: "cloud.fill",          temperature: 69),
        Hour(time: "6PM", symbol: "cloud.drizzle.fill",  temperature: 66),
        Hour(time: "7PM", symbol: "cloud.rain.fill",     temperature: 63),
        Hour(time: "8PM", symbol: "cloud.bolt.rain.fill", temperature: 61),
        Hour(time: "9PM", symbol: "cloud.moon.fill",     temperature: 59),
        Hour(time: "10PM", symbol: "moon.stars.fill",    temperature: 57),
        Hour(time: "11PM", symbol: "moon.stars.fill",    temperature: 55),
        Hour(time: "12AM", symbol: "moon.fill",          temperature: 54)
    ]
}
