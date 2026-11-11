import SwiftUI

// The main screen. It owns the data with @State and hands $bindings
// to the smaller views so they can change it.
struct ContentView: View {
    // @State: data that belongs to this view. Changing it redraws the screen.
    @State var isEditing = false
    @State var page = RemindersPage(
        title: "Reminders",
        items: [
            Reminder(title: "Finish WeatherApp project"),
            Reminder(title: "Read about @Binding", isCompleted: true),
            Reminder(title: "Buy groceries"),
            Reminder(title: "Go to App Team Carolina meeting")
        ],
        color: .orange
    )

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // $isEditing passes a binding, so the header can set isEditing = true
            PageHeaderView(title: page.title, color: page.color, isEditing: $isEditing)

            // A plain List of reminders.
            // ForEach($page.items) gives each row a binding ($reminder) to one item in the array,
            // so the row can change that item directly.
            List {
                ForEach($page.items) { $reminder in
                    ReminderRowView(reminder: $reminder, color: page.color)
                }
                // Swipe left on a row to delete it
                .onDelete { offsets in
                    page.items.remove(atOffsets: offsets)
                }
            }
            .listStyle(.plain)

            // Footer button that adds an empty reminder to the end of the list
            Button {
                page.items.append(Reminder(title: ""))
            } label: {
                Label("New Reminder", systemImage: "plus.circle.fill")
                    .font(.headline)
                    .foregroundStyle(page.color)
            }
            .padding()
        }
        // .sheet slides up a new view while isEditing is true.
        // When the sheet is closed, SwiftUI sets isEditing back to false.
        .sheet(isPresented: $isEditing) {
            EditSheet(title: $page.title, selectedColor: $page.color)
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
