import SwiftUI

struct QuestionView: View {
    @ObservedObject var question: Question

    var body: some View {
        VStack(alignment: .leading) {
            Text(question.text)
                .font(.title)

            ForEach(question.answers, id: \.self) { answer in
                Button(action: {
                    question.selectedAnswer = answer
                }) {
                    HStack {
                        Text(answer.text)
                        Spacer()
                        if question.selectedAnswer == answer {
                            Image(systemName: answer.isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundColor(answer.isCorrect ? .green : .red)
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .padding()
                .background(Color(answer.isCorrect ? .green : .red).opacity(question.selectedAnswer == answer ? 0.3 : 0))
                .cornerRadius(10)
            }
        }
    }
}
