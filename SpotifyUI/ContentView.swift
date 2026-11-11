import SwiftUI

// ContentView is the whole "Now Playing" screen.
// It owns all the @State, which is data that can change. When @State changes,
// SwiftUI redraws the views that use it.
// The child views get a $binding to this state so they can change it too.
struct ContentView: View {
    // MARK: - State (data that changes while the app runs)
    @State private var isPlaying = false
    @State private var isLiked = false
    @State private var isShuffleOn = false
    @State private var isRepeatOn = false
    @State private var currentTime: Double = 83     // seconds elapsed (starts at 1:23)

    // Song info. `let` means these never change.
    let songTitle = "Bohemian Rhapsody"
    let artist = "Queen"
    let album = "A Night at the Opera"
    let songLength: Double = 355                     // 5:55 = 5*60 + 55 seconds

    var body: some View {
        // ZStack layers views on top of each other (back → front).
        // The gradient goes in the back and the content sits on top.
        ZStack {
            // LinearGradient blends colors along a direction (top → bottom here).
            LinearGradient(
                colors: [Color(red: 0.55, green: 0.05, blue: 0.08), .black],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()   // stretch behind the notch and home bar

            // VStack stacks its children vertically. `spacing` is the gap between them.
            VStack(spacing: 24) {
                // Small header, like Spotify's "PLAYING FROM ALBUM"
                VStack(spacing: 2) {
                    Text("PLAYING FROM ALBUM")
                        .font(.caption2)
                        .foregroundStyle(.white.opacity(0.7))
                    Text(album)
                        .font(.caption)
                        .bold()
                        .foregroundStyle(.white)
                }

                // Spacer takes up all the empty space it can, which pushes the other views apart.
                Spacer()

                AlbumArtView(imageName: "bohemian")

                Spacer()

                SongInfoView(title: songTitle, artist: artist, isLiked: $isLiked)

                SongProgressView(currentTime: $currentTime, songLength: songLength)

                ControlsView(isPlaying: $isPlaying,
                             isShuffleOn: $isShuffleOn,
                             isRepeatOn: $isRepeatOn)

                Spacer()
            }
            .padding(.horizontal, 24)   // gap on the left and right sides
            .padding(.vertical)
        }
    }
}

// #Preview shows the screen in Xcode's canvas (Option+Cmd+Return to open it).
#Preview {
    ContentView()
}
