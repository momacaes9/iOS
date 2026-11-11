import SwiftUI

// ContentView is the whole "Now Playing" screen.
// It owns all the @State, which is data that can change. When @State changes,
// SwiftUI redraws the views that use it.
// The child views get a $binding to this state so they can change it too.
struct ContentView: View {
    // MARK: - State (data that changes while the app runs)
    @State private var isPlaying = false
    @State private var isAdded = false               // added to your library?
    @State private var isShuffleOn = false
    @State private var isRepeatOn = false
    @State private var currentTime: Double = 83     // seconds elapsed (starts at 1:23)

    // Song info. `let` means these never change.
    let songTitle = "Bohemian Rhapsody"
    let artist = "Queen"
    let songLength: Double = 349                     // 5:49 = 5*60 + 49 seconds

    var body: some View {
        // ZStack layers views on top of each other (back → front).
        // The gradient goes in the back and the content sits on top.
        ZStack {
            // LinearGradient blends colors along a direction (top → bottom here).
            // The colors come from the album art: purple sky → orange stage → near-black.
            LinearGradient(
                colors: [
                    Color(red: 0.36, green: 0.16, blue: 0.42),   // deep purple
                    Color(red: 0.30, green: 0.14, blue: 0.08),   // dark orange-brown
                    Color(red: 0.07, green: 0.05, blue: 0.05)    // near-black
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()   // stretch behind the notch and home bar

            // VStack stacks its children vertically. `spacing` is the gap between them.
            VStack(spacing: 24) {
                // Spacer takes up all the empty space it can, which pushes the other views apart.
                Spacer()

                AlbumArtView(imageName: "bohemian")

                Spacer()

                SongInfoView(title: songTitle, artist: artist, isAdded: $isAdded)

                SongProgressView(currentTime: $currentTime, songLength: songLength)

                ControlsView(isPlaying: $isPlaying,
                             isShuffleOn: $isShuffleOn,
                             isRepeatOn: $isRepeatOn)

                Spacer()
            }
            .padding(.horizontal, 24)   // gap on the left and right sides
            .padding(.vertical)
        }
        .statusBarHidden(true)   // hide the time, wifi and battery at the top
    }
}

// #Preview shows the screen in Xcode's canvas (Option+Cmd+Return to open it).
#Preview {
    ContentView()
}
