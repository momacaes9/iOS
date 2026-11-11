import SwiftUI

@main
struct TrivveyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)   // our palette is dark, so keep text light
        }
    }
}
