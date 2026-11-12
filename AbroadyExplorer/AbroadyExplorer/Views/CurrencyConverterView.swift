import SwiftUI

// Converts US dollars into the country's currency using today's Frankfurter rates.
struct CurrencyConverterView: View {
    let currency: Country.Currency?

    // @Binding: the amount belongs to CountryDetailView. The converter just edits it.
    @Binding var amountText: String

    // @State for the downloaded rates and the loading/error status
    @State private var rates: ExchangeRates? = nil
    @State private var isLoading = false
    @State private var loadError: APIError? = nil

    // @FocusState tracks whether the keyboard is open for the text field
    @FocusState private var isAmountFocused: Bool

    // Turn the typed text into a number. Accepts "12.5" and "12,5" (some countries type a comma).
    var amount: Double {
        Double(amountText.replacingOccurrences(of: ",", with: ".")) ?? 0
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Label("Currency converter", systemImage: "arrow.left.arrow.right.circle.fill")
                .font(.headline)
                .foregroundStyle(.tint)

            // USD input
            HStack {
                Text("USD")
                    .font(.title3.bold())
                    .foregroundStyle(.secondary)
                TextField("Amount", text: $amountText)
                    .keyboardType(.decimalPad)      // number keyboard with a decimal point
                    .focused($isAmountFocused)
                    .font(.title3)
                    .padding(10)
                    .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 10))
            }

            result
        }
        .toolbar {
            // The decimal keyboard has no Return key, so we add a Done button above it
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") { isAmountFocused = false }
            }
        }
        // Download the rates when the converter appears
        .task {
            await loadRates()
        }
    }

    // The bottom part changes depending on what we know so far
    @ViewBuilder
    var result: some View {
        if let currency {
            if isLoading {
                LoadingView(message: "Getting today's rates…")
                    .frame(height: 80)
            } else if let loadError {
                ErrorView(error: loadError, retry: loadRates)
            } else if let rates, let rate = rates.rate(for: currency.code) {
                VStack(alignment: .leading, spacing: 4) {
                    // .currency(code:) formats with the right symbol and decimals, e.g. "€90.25"
                    Text((amount * rate).formatted(.currency(code: currency.code)))
                        .font(.largeTitle.bold())
                        .minimumScaleFactor(0.5)    // shrink big numbers instead of cutting them off
                        .lineLimit(1)
                    Text("1 USD = \(rate.formatted()) \(currency.code) · rates from \(rates.date)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            } else {
                // Frankfurter only has about 30 currencies
                Label("Sorry, there are no exchange rates for \(currency.name ?? currency.code) (\(currency.code)) yet.",
                      systemImage: "exclamationmark.triangle")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        } else {
            Label("This country has no currency listed.", systemImage: "questionmark.circle")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    func loadRates() async {
        isLoading = true
        loadError = nil
        do {
            rates = try await ExchangeService.fetchRates(base: "USD")
        } catch {
            loadError = APIError.from(error)
        }
        isLoading = false
    }
}

#Preview {
    @Previewable @State var amount = "100"
    CurrencyConverterView(currency: Country.sampleJapan.mainCurrency, amountText: $amount)
        .padding()
}
