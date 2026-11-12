import SwiftUI

// A spinner with a short message, shown while data downloads.
struct LoadingView: View {
    var message = "Loading…"     // a default value, so LoadingView() also works

    var body: some View {
        VStack(spacing: 12) {
            ProgressView()          // the spinning circle
                .controlSize(.large)
            Text(message)
                .foregroundStyle(.secondary)
        }
        // Take all the space so the spinner sits in the middle of the screen
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LoadingView(message: "Loading countries…")
}
