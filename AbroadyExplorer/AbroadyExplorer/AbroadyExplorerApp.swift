import SwiftUI

// @main marks where the app starts. WindowGroup shows the first screen.
@main
struct AbroadyExplorerApp: App {
    // init runs once when the app starts.
    // Segmented pickers normally make every segment the same width, which cuts "Americas" off.
    // This UIKit setting sizes each segment to fit its text instead.
    init() {
        UISegmentedControl.appearance().apportionsSegmentWidthsByContent = true
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
