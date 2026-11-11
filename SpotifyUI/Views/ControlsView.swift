import SwiftUI

// The playback buttons: shuffle, previous, play/pause, next, repeat.
// Every icon is an SF Symbol, one of Apple's built-in icons.
// To browse them, download the free "SF Symbols" app from Apple.
struct ControlsView: View {
    @Binding var isPlaying: Bool
    @Binding var isShuffleOn: Bool
    @Binding var isRepeatOn: Bool

    var body: some View {
        HStack {
            // Shuffle: green when on, white when off (ternary operator)
            Button {
                isShuffleOn.toggle()
            } label: {
                Image(systemName: "shuffle")
                    .font(.title3)
                    .foregroundStyle(isShuffleOn ? .green : .white)
            }

            Spacer()

            // Previous track (it only looks like a button for this project)
            Button {
                // TODO: go to the previous song
            } label: {
                Image(systemName: "backward.end.fill")
                    .font(.title)
                    .foregroundStyle(.white)
            }

            Spacer()

            // Play / Pause: the icon switches depending on isPlaying
            Button {
                isPlaying.toggle()
            } label: {
                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .font(.system(size: 70))
                    .foregroundStyle(.white)
            }

            Spacer()

            // Next track
            Button {
                // TODO: go to the next song
            } label: {
                Image(systemName: "forward.end.fill")
                    .font(.title)
                    .foregroundStyle(.white)
            }

            Spacer()

            // Repeat: green when on
            Button {
                isRepeatOn.toggle()
            } label: {
                Image(systemName: "repeat")
                    .font(.title3)
                    .foregroundStyle(isRepeatOn ? .green : .white)
            }
        }
    }
}

#Preview {
    ControlsView(isPlaying: .constant(false),
                 isShuffleOn: .constant(true),
                 isRepeatOn: .constant(false))
        .padding()
        .background(.black)
}
