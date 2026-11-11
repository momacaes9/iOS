import Foundation

// One trivia question. It matches each object in questions.json, which looks like this:
// { "question": "A pita is a type of what?",
//   "A": "fresh fruit", "B": "flat bread", "C": "French tart", "D": "friend bean dip",
//   "answer": "B" }
//
// Codable means Swift can turn JSON into this struct (decoding) and back (encoding).
// Identifiable lets List and ForEach tell the questions apart.
struct Question: Codable, Identifiable {
    let question: String
    let a: String
    let b: String
    let c: String
    let d: String
    let answer: String      // the letter of the correct choice: "A", "B", "C" or "D"

    // CodingKeys connects our Swift names to the names in the JSON.
    // In the JSON the choices are uppercase "A"..."D", but Swift names are usually lowercase.
    enum CodingKeys: String, CodingKey {
        case question, answer
        case a = "A"
        case b = "B"
        case c = "C"
        case d = "D"
    }

    // Every question's text is different, so we can use it as the id.
    var id: String { question }

    // The four choices as (letter, text) pairs, which makes them easy to loop over with ForEach.
    var choices: [(letter: String, text: String)] {
        [("A", a), ("B", b), ("C", c), ("D", d)]
    }

    // The text of the correct choice, e.g. "flat bread"
    var correctText: String {
        choices.first { $0.letter == answer }?.text ?? ""
    }
}
