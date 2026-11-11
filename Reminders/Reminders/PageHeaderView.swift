import SwiftUI

// The big list title plus the info button that opens the edit sheet.
struct PageHeaderView: View {
    let title: String
    let color: Color

    // @Binding: this view doesn't own isEditing. It changes the @State in ContentView.
    @Binding var isEditing: Bool

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 40, weight: .bold, design: .rounded))   // custom font size
                .foregroundStyle(color)

            Spacer()

            Button {
                isEditing = true   // this opens the sheet in ContentView
            } label: {
                Image(systemName: "info.circle")
                    .font(.title2)
                    .foregroundStyle(color)
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

#Preview {
    @Previewable @State var isEditing = false
    PageHeaderView(title: "Reminders", color: .orange, isEditing: $isEditing)
        .preferredColorScheme(.dark)
}
