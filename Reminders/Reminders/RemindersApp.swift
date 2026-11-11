import SwiftUI

@main
struct RemindersApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)   // always use dark mode, like the real app at night
        }
    }
}
