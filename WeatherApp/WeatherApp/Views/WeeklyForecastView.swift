import SwiftUI

// The "10-DAY FORECAST" card.
struct WeeklyForecastView: View {
    let days: [Day]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Label shows an icon and text together
            Label("10-DAY FORECAST", systemImage: "calendar")
                .font(.caption)
                .opacity(0.7)

            // ForEach makes one row per day. A Divider goes above each row.
            ForEach(days) { day in
                Divider()
                    .overlay(.white.opacity(0.4))
                WeeklyRowView(day: day)
            }
        }
        .padding()
        .background(.black.opacity(0.12), in: RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    WeeklyForecastView(days: Day.makeSampleData())
        .foregroundStyle(.white)
        .padding()
        .background(.blue)
}
