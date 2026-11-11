import SwiftUI

// One day: name, icon, low, temperature bar, high.
struct WeeklyRowView: View {
    let day: Day

    var body: some View {
        HStack(spacing: 12) {
            Text(day.name)
                .font(.title3)
                .frame(width: 70, alignment: .leading)   // fixed width so the rows line up

            Image(systemName: day.symbol)
                .symbolRenderingMode(.multicolor)
                .font(.title3)
                .frame(width: 30)

            Text("\(day.low)°")
                .font(.title3)
                .opacity(0.6)
                .frame(width: 40, alignment: .trailing)

            TemperatureBarView(low: day.low, high: day.high,
                               weekLow: Day.weekLow, weekHigh: Day.weekHigh)

            Text("\(day.high)°")
                .font(.title3)
                .frame(width: 40, alignment: .trailing)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    WeeklyRowView(day: Day(name: "Today", symbol: "sun.max.fill", low: 54, high: 72))
        .foregroundStyle(.white)
        .padding()
        .background(.blue)
}
