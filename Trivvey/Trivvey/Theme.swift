import SwiftUI

// Our custom color palette. Keeping colors in one place means
// we can change the whole look of the app by editing just this file.
// `extension Color` adds new named colors, so we can write Color.trivNavy.
extension Color {
    static let trivNavy  = Color(red: 0.09, green: 0.11, blue: 0.24)   // background
    static let trivCard  = Color(red: 0.16, green: 0.19, blue: 0.36)   // cards and rows
    static let trivGold  = Color(red: 1.00, green: 0.78, blue: 0.30)   // accent / highlights
    static let trivMint  = Color(red: 0.36, green: 0.85, blue: 0.62)   // correct
    static let trivCoral = Color(red: 1.00, green: 0.42, blue: 0.42)   // wrong
}
