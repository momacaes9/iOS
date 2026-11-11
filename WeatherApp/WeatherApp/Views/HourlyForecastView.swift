import SwiftUI

// The rounded card with hours you can scroll sideways.
struct HourlyForecastView: View {
    let hours: [Hour]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Rain expected around 7PM. Wind gusts are up to 12 mph.")
                .font(.subheadline)

            Divider()
                .overlay(.white.opacity(0.4))

            // A horizontal ScrollView scrolls left and right.
            ScrollView(.horizontal) {
                HStack(spacing: 22) {
                    // ForEach makes one HourlyRowView for each Hour in the array.
                    ForEach(hours) { hour in
                        HourlyRowView(hour: hour)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding()
        // A translucent card: a see-through color clipped to a rounded rectangle
        .background(.black.opacity(0.12), in: RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    HourlyForecastView(hours: Hour.sampleData)
        .foregroundStyle(.white)
        .padding()
        .background(.blue)
}
