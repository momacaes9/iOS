import SwiftUI

// Challenge: the temperature range bar.
// The dark outer capsule is the whole week's range.
// The bright inner capsule shows this day's range: where it starts is the low, and its width is high minus low.
struct TemperatureBarView: View {
    let low: Int
    let high: Int
    let weekLow: Int
    let weekHigh: Int

    var body: some View {
        // GeometryReader tells us how much space we have (geo.size.width),
        // so we can turn temperatures into widths.
        GeometryReader { geo in
            let range = Double(weekHigh - weekLow)
            let start = Double(low - weekLow) / range          // 0.0 ... 1.0
            let length = Double(high - low) / range            // 0.0 ... 1.0

            // ZStack(alignment: .leading) stacks the capsules and lines them up on the left
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(.black.opacity(0.2))                  // darker outer capsule

                Capsule()
                    .fill(LinearGradient(colors: [.green, .yellow, .orange],
                                         startPoint: .leading, endPoint: .trailing))
                    .frame(width: geo.size.width * length)      // how long the bar is
                    .offset(x: geo.size.width * start)          // where the bar starts
            }
        }
        .frame(height: 5)
    }
}

#Preview {
    TemperatureBarView(low: 55, high: 70, weekLow: 48, weekHigh: 78)
        .padding()
        .background(.blue)
}
