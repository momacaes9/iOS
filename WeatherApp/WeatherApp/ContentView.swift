import SwiftUI

// The main screen. It puts the smaller views together, which keeps each file short and easy to read.
struct ContentView: View {
    // The 10-day data is made once when the screen appears.
    // @State keeps it the same while the screen redraws.
    @State private var days = Day.makeSampleData()

    var body: some View {
        ZStack {
            // Blue sky gradient behind everything
            LinearGradient(
                colors: [Color(red: 0.20, green: 0.45, blue: 0.80),
                         Color(red: 0.42, green: 0.66, blue: 0.92)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // A vertical ScrollView lets the whole screen scroll when content is taller than the phone.
            ScrollView {
                VStack(spacing: 16) {
                    HeaderView(location: "Chapel Hill",
                               temperature: 68,
                               condition: "Mostly Sunny",
                               high: 72,
                               low: 54)

                    HourlyForecastView(hours: Hour.sampleData)

                    WeeklyForecastView(days: days)
                }
                .padding()
            }
            .scrollIndicators(.hidden)
        }
        .foregroundStyle(.white)   // modifiers set on a parent apply to all the text inside it
        .preferredColorScheme(.dark)   // makes the status bar (time, battery) white too
    }
}

#Preview {
    ContentView()
}
