import SwiftUI

// One column in the hourly forecast: time, icon, temperature.
struct HourlyRowView: View {
    let hour: Hour

    var body: some View {
        VStack(spacing: 12) {
            Text(hour.time)
                .font(.subheadline)
                .bold()

            Image(systemName: hour.symbol)
                // .multicolor uses Apple's built-in colors (yellow sun, white cloud, blue rain)
                .symbolRenderingMode(.multicolor)
                .font(.title2)
                .frame(height: 30)

            Text("\(hour.temperature)°")
                .font(.title3)
        }
    }
}

#Preview {
    HourlyRowView(hour: Hour.sampleData[0])
        .foregroundStyle(.white)
        .padding()
        .background(.blue)
}
