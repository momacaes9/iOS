import SwiftUI

// Shows one question with its four choices. Tap a choice to see if you were right.
struct QuestionView: View {
    let question: Question
    let number: Int

    // The letter the user picked. It's nil (nothing) until they tap a choice.
    // The `?` makes it an Optional, which means it can be empty.
    @State private var selectedLetter: String? = nil

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("QUESTION \(number)")
                    .font(.caption.bold())
                    .foregroundStyle(Color.trivGold)

                Text(question.question)
                    .font(.title2.bold())

                // One ChoiceButton per choice. We pass $selectedLetter as a binding
                // so the button can set which letter was picked.
                ForEach(question.choices, id: \.letter) { choice in
                    ChoiceButton(letter: choice.letter,
                                 text: choice.text,
                                 correctLetter: question.answer,
                                 selectedLetter: $selectedLetter)
                }

                // Feedback appears only after a choice is picked
                if let picked = selectedLetter {
                    if picked == question.answer {
                        Label("Correct!", systemImage: "checkmark.circle.fill")
                            .font(.title3.bold())
                            .foregroundStyle(Color.trivMint)
                    } else {
                        Label("Not quite. The answer is \(question.answer): \(question.correctText)",
                              systemImage: "xmark.circle.fill")
                            .font(.title3.bold())
                            .foregroundStyle(Color.trivCoral)
                    }

                    Button("Try Again") {
                        selectedLetter = nil   // clear the pick so you can answer again
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
        }
        .background(Color.trivNavy)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// One answer button. Its color depends on whether it was picked and whether it's correct.
struct ChoiceButton: View {
    let letter: String
    let text: String
    let correctLetter: String

    // @Binding: this button can change the selectedLetter @State that lives in QuestionView
    @Binding var selectedLetter: String?

    var body: some View {
        Button {
            // Only allow one pick. After that, the buttons stop changing it.
            if selectedLetter == nil {
                selectedLetter = letter
            }
        } label: {
            HStack(spacing: 12) {
                Text(letter)
                    .font(.headline)
                    .frame(width: 32, height: 32)
                    .background(Color.trivNavy, in: Circle())
                Text(text)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .foregroundStyle(.white)
            .padding()
            .background(backgroundColor, in: RoundedRectangle(cornerRadius: 12))
        }
    }

    // A computed property: the color is worked out each time the view redraws.
    var backgroundColor: Color {
        if selectedLetter == nil {
            return Color.trivCard                        // nothing picked yet
        } else if letter == correctLetter {
            return Color.trivMint.opacity(0.8)           // always show the right answer
        } else if letter == selectedLetter {
            return Color.trivCoral.opacity(0.8)          // the wrong one you picked
        } else {
            return Color.trivCard.opacity(0.5)           // the other choices fade out
        }
    }
}

#Preview {
    NavigationStack {
        QuestionView(question: Question(question: "A pita is a type of what?",
                                        a: "fresh fruit", b: "flat bread",
                                        c: "French tart", d: "friend bean dip",
                                        answer: "B"),
                     number: 3)
    }
    .preferredColorScheme(.dark)
}
