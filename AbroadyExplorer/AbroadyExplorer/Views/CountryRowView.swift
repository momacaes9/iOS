import SwiftUI

// One row in the country list: flag, name, capital and a region chip.
// It's a reusable subview: the list makes one for each country with ForEach.
struct CountryRowView: View {
    let country: Country

    var body: some View {
        HStack(spacing: 14) {
            FlagImageView(country: country, width: 56)

            VStack(alignment: .leading, spacing: 4) {
                Text(country.name)
                    .font(.headline)
                // Label shows an SF Symbol next to the text
                Label(country.capital, systemImage: "building.columns")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            if let region = country.region {
                RegionChipView(region: region)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    List {
        CountryRowView(country: .sampleFrance)
        CountryRowView(country: .sampleJapan)
    }
}
