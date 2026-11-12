import SwiftUI

// One fact on the detail screen: an icon, a title and a value.
// For example: 🏛 Capital ........ Paris
// The detail view makes several of these with ForEach.
struct InfoRowView: View {
    let icon: String        // SF Symbol name
    let title: String
    let value: String

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(.tint)
                .frame(width: 24)           // same width on every row, so the titles line up

            Text(title)
                .foregroundStyle(.secondary)

            Spacer(minLength: 16)

            Text(value)
                .fontWeight(.semibold)
                .multilineTextAlignment(.trailing)
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    VStack {
        InfoRowView(icon: "building.columns", title: "Capital", value: "Paris")
        InfoRowView(icon: "person.3", title: "Population", value: "68,000,000")
    }
    .padding()
}
