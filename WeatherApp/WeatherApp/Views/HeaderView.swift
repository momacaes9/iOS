import SwiftUI

// The big text at the top: city, temperature, condition, high/low.
struct HeaderView: View {
    let location: String
    let temperature: Int
    let condition: String
    let high: Int
    let low: Int

    var body: some View {
        VStack(spacing: 4) {
            Text(location)
                .font(.largeTitle)

            // "\(value)" puts a value inside a string (string interpolation)
            Text("\(temperature)°")
                .font(.system(size: 96, weight: .thin))

            Text(condition)
                .font(.title3)
                .opacity(0.8)

            Text("H:\(high)°  L:\(low)°")
                .font(.title3)
        }
        .padding(.vertical, 32)
    }
}

#Preview {
    HeaderView(location: "Chapel Hill", temperature: 68, condition: "Mostly Sunny", high: 72, low: 54)
        .foregroundStyle(.white)
        .background(.blue)
}
