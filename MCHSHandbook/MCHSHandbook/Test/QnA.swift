import Foundation

struct Answer: Identifiable, Hashable {
    var id = UUID()
    var text: String
    var isCorrect: Bool
    var isSelected = false
}

class TestStore: ObservableObject {
    @Published var tests: [Quiz] = []
    
    func addTest(test: Quiz) {
        tests.append(test)
    }
    
    func removeTest(test: Quiz) {
        if let index = tests.firstIndex(where: { $0.id == test.id }) {
            tests.remove(at: index)
        }
    }
}


class Question: Identifiable, ObservableObject, Hashable {
    let id = UUID()
    @Published var text: String
    @Published var answers: [Answer]
    @Published var selectedAnswer: Answer? = nil
    
    init(text: String, answers: [Answer]) {
        self.text = text
        self.answers = answers
    }
    
    var hasCorrectAnswer: Bool {
        return answers.contains { $0.isCorrect }
    }
    
    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class Quiz: Identifiable, ObservableObject {
    let id = UUID()
    @Published var title: String
    @Published var questions: [Question]
    
    init(title: String, questions: [Question]) {
        self.title = title
        self.questions = questions
    }
    
    func addQuestion(question: Question) {
        questions.append(question)
    }
    
    func removeQuestion(question: Question) {
        if let index = questions.firstIndex(where: { $0.id == question.id }) {
            questions.remove(at: index)
        }
    }
}
