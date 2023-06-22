import SwiftUI

struct TestDetailView: View {
    @ObservedObject var testStore: TestStore
    var test: Test?
    
    var body: some View {
        ScrollView {
            if let test = test, let title = test.title {
                Text(title)
                    .font(.title)
                    .bold()
                    .padding()
            } else {
                Text("No title")
            }

            
            if let questionSet = test?.questions as? Set<Question> {
                let questions = Array(questionSet)
                
                ForEach(questions, id: \.self) { question in
                    QuestionView(question: question)
                }
                
                let correctCount = questions.reduce(0) { count, question in
                    return count + (question.selectedAnswer?.isCorrect == true ? 1 : 0)
                }
                
                let incorrectCount = questions.count - correctCount
                
                Text("Правильные ответы: \(correctCount)")
                Text("Неправильные ответы: \(incorrectCount)")
            }
        }
        .navigationTitle("Тест")
    }
}
