import SwiftUI

// A friendly error screen with a Retry button.
// Both APIs use it: the country list and the currency converter.
struct ErrorView: View {
    let message: String
    let retry: () async -> Void     // what to run when Retry is tapped

    var body: some View {
        // ContentUnavailableView is Apple's ready-made "empty / error" layout
        ContentUnavailableView {
            Label("Something went wrong", systemImage: "wifi.exclamationmark")
        } description: {
            Text(message)
        } actions: {
            Button("Retry") {
                // Buttons can't await directly, so we start a Task to run async code
                Task { await retry() }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ErrorView(message: "Couldn't reach the server. Check your internet connection and try again.", retry: {})
}
