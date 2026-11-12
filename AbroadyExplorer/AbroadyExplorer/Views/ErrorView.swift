import SwiftUI

// A friendly error screen with a Retry button.
// Both APIs use it: the country list and the currency converter.
// The title, icon and message all come from the APIError, so each problem looks different.
struct ErrorView: View {
    let error: APIError
    let retry: () async -> Void     // what to run when Retry is tapped

    var body: some View {
        // ContentUnavailableView is Apple's ready-made "empty / error" layout
        ContentUnavailableView {
            Label(error.title, systemImage: error.symbolName)
        } description: {
            Text(error.errorDescription ?? "Please try again.")
        } actions: {
            Button {
                // Buttons can't await directly, so we start a Task to run async code
                Task { await retry() }
            } label: {
                Label("Retry", systemImage: "arrow.clockwise")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ErrorView(error: .missingKey, retry: {})
}
