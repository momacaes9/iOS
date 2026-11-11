import SwiftUI

// One reminder: a circle you tap to complete it, and a title you can edit.
struct ReminderRowView: View {
    // @Binding to one Reminder inside the page's items array
    @Binding var reminder: Reminder
    let color: Color

    var body: some View {
        HStack(spacing: 12) {
            Button {
                reminder.isCompleted.toggle()   // flip done / not done
            } label: {
                // Ternary: a filled circle when done, an empty one when not
                Image(systemName: reminder.isCompleted ? "largecircle.fill.circle" : "circle")
                    .font(.title2)
                    .foregroundStyle(reminder.isCompleted ? color : .gray)
            }
            .buttonStyle(.plain)   // so tapping the row doesn't also trigger the button

            // TextField edits the title directly through the binding
            TextField("New Reminder", text: $reminder.title)
                .foregroundStyle(reminder.isCompleted ? .gray : .primary)
        }
        .padding(.vertical, 4)
    }
}

// @Previewable lets a preview have its own @State, so the row actually works in the canvas.
#Preview {
    @Previewable @State var reminder = Reminder(title: "Try tapping the circle")
    ReminderRowView(reminder: $reminder, color: .orange)
        .padding()
        .preferredColorScheme(.dark)
}
