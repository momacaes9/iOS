import SwiftUI

// The home screen: a list of all the questions.
struct ContentView: View {
    // Starts empty and gets filled from questions.json in .onAppear
    @State private var questions: [Question] = []

    var body: some View {
        // NavigationStack lets us "push" a new screen (QuestionView) and go back with the back button.
        NavigationStack {
            List {
                // enumerated() gives us the position too, so we can number the questions
                ForEach(Array(questions.enumerated()), id: \.element.id) { index, question in
                    // NavigationLink: tapping the row opens QuestionView for that question
                    NavigationLink {
                        QuestionView(question: question, number: index + 1)
                    } label: {
                        HStack(alignment: .top, spacing: 12) {
                            Text("\(index + 1)")
                                .font(.headline)
                                .foregroundStyle(Color.trivGold)
                                .frame(width: 36, alignment: .leading)
                            Text(question.question)
                                .lineLimit(2)
                        }
                        .padding(.vertical, 4)
                    }
                    .listRowBackground(Color.trivCard)
                }
            }
            .scrollContentBackground(.hidden)   // hide the default gray so our color shows
            .background(Color.trivNavy)
            .navigationTitle("Trivvey")
            .toolbar {
                // A button in the top-right corner of the navigation bar
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        questions.shuffle()   // shuffle() mixes up the order of an array
                    } label: {
                        Image(systemName: "shuffle")
                    }
                }
            }
            .onAppear {
                // Only load once. onAppear also runs again when you come back from a question.
                if questions.isEmpty {
                    questions = loadQuestions()
                }
            }
        }
        .tint(Color.trivGold)   // color for buttons and the back arrow
    }

    // Reads questions.json from the app bundle and decodes it into [Question].
    func loadQuestions() -> [Question] {
        // 1. Find the file inside the app
        guard let url = Bundle.main.url(forResource: "questions", withExtension: "json") else {
            print("questions.json not found in the app bundle")
            return []
        }
        do {
            // 2. Read the raw bytes, then 3. decode the JSON into Swift structs.
            // `try` is needed because these steps can fail. If they do, we jump to `catch`.
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Question].self, from: data)
        } catch {
            print("Could not decode questions.json: \(error)")
            return []
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
