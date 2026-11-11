import SwiftUI

// The sheet for changing the list's name and color.
// Both values are @Bindings, so changes show up on the main screen right away.
struct EditSheet: View {
    @Binding var title: String
    @Binding var selectedColor: Color

    // dismiss is an action SwiftUI gives us to close the sheet
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Spacer()
                Button("Done") { dismiss() }
                    .bold()
            }

            Image(systemName: "list.bullet.circle.fill")
                .font(.system(size: 90))
                .foregroundStyle(selectedColor)

            TextField("List Name", text: $title)
                .font(.title2.bold())
                .multilineTextAlignment(.center)
                .foregroundStyle(selectedColor)
                .padding()
                .background(Color.secondary.opacity(0.15), in: RoundedRectangle(cornerRadius: 12))

            // We pass our binding along to ColorChooser
            ColorChooser(selectedColor: $selectedColor)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var title = "Reminders"
    @Previewable @State var color = Color.orange
    EditSheet(title: $title, selectedColor: $color)
        .preferredColorScheme(.dark)
}
