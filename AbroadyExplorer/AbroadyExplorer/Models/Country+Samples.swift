import Foundation

// Sample countries for Xcode #Previews only, so the canvas works without internet or an API key.
// The real app always loads countries from the REST Countries API.
// `extension` adds extra code to a type we already made.
extension Country {
    static let sampleFrance = Country(
        names: Names(common: "France", official: "French Republic"),
        codes: Codes(alpha2: "FR"),
        capitals: [Capital(name: "Paris", primary: true)],
        flag: Flag(emoji: "🇫🇷", urlPNG: "https://flags.restcountries.com/v5/w640/fr.png"),
        region: "Europe",
        subregion: "Western Europe",
        population: 68_000_000,
        languages: [Language(name: "French")],
        currencies: [Currency(code: "EUR", name: "Euro", symbol: "€")]
    )

    static let sampleJapan = Country(
        names: Names(common: "Japan", official: "Japan"),
        codes: Codes(alpha2: "JP"),
        capitals: [Capital(name: "Tokyo", primary: true)],
        flag: Flag(emoji: "🇯🇵", urlPNG: "https://flags.restcountries.com/v5/w640/jp.png"),
        region: "Asia",
        subregion: "Eastern Asia",
        population: 124_000_000,
        languages: [Language(name: "Japanese")],
        currencies: [Currency(code: "JPY", name: "Japanese yen", symbol: "¥")]
    )

    static let samples = [sampleFrance, sampleJapan]
}
