import SwiftUI

// The progress slider with elapsed time on the left and remaining time on the right.
// (It's called SongProgressView because SwiftUI already has a built-in view named ProgressView.)
struct SongProgressView: View {
    @Binding var currentTime: Double   // seconds elapsed (shared with ContentView)
    let songLength: Double             // total seconds

    var body: some View {
        VStack(spacing: 4) {
            // A Slider needs a binding ($) so dragging it changes currentTime.
            // `in: 0...songLength` sets the minimum and maximum values.
            Slider(value: $currentTime, in: 0...songLength)
                .tint(.white)   // color of the filled part of the track

            HStack {
                // Because the Slider changes currentTime, these labels update while you drag.
                Text(formatTime(currentTime))
                Spacer()
                Text("-" + formatTime(songLength - currentTime))
            }
            .font(.caption)
            .foregroundStyle(.white.opacity(0.7))
        }
    }

    // Turns seconds into "m:ss". For example, 75 → "1:15".
    func formatTime(_ seconds: Double) -> String {
        let total = Int(seconds)
        let minutes = total / 60
        let secs = total % 60
        // %02d pads with a zero, so 5 seconds shows as "05"
        return String(format: "%d:%02d", minutes, secs)
    }
}

#Preview {
    SongProgressView(currentTime: .constant(83), songLength: 355)
        .padding()
        .background(.black)
}
