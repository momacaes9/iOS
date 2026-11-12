import SwiftUI

// A small rounded "chip" showing a region name, like "Europe".
// It's reused in every list row and on the detail screen.
struct RegionChipView: View {
    let region: String

    var body: some View {
        Text(region)
            .font(.caption.bold())
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            // .tint is the app's accent color, set once in the app file
            .foregroundStyle(.tint)
            .background(.tint.opacity(0.15), in: Capsule())
    }
}

#Preview {
    HStack {
        RegionChipView(region: "Europe")
        RegionChipView(region: "Western Europe")
    }
}
