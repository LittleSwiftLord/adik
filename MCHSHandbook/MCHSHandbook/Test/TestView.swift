import Foundation
import SwiftUI
import CoreData

struct TestView: View {
    var test: Quiz

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(test.questions, id: \.id) { question in
                    QuestionView(question: question)
                }
            }
            .padding()
        }
        .navigationBarTitle(test.title, displayMode: .inline)
    }
}
