import SwiftUI
import CoreData

struct AddEditTestView: View {
    @ObservedObject var testStore: TestStore
    var test: Test? 
    @Environment(\.presentationMode) var presentationMode
    var testIndex: Int? = nil

    @State private var title: String = ""
    @State private var questions: [Question] = []

    var body: some View {
           NavigationView {
               Form {
                   Section {
                       TextField("Название", text: $title)
                   }
                   
                   Section(header: Text("Вопросы")) {
                       ForEach(questions.indices, id: \.self) { index in
                           Section(header: Text("Вопрос \(index + 1)")) {
                               TextField("Вопрос", text: $questions[index].text)
                               
                               ForEach(questions[index].answers.indices, id: \.self) { answerIndex in
                                   TextField("Ответ", text: $questions[index].answers[answerIndex].text)
                                   Toggle("Правильный", isOn: $questions[index].answers[answerIndex].isCorrect)
                               }
                           }
                       }
                       
                       Button(action: {
                           addQuestion()
                       }) {
                           Text("Добавить вопрос")
                       }
                   }
               }
               .navigationBarItems(
                   leading: Button("Отмена") {
                       self.presentationMode.wrappedValue.dismiss()
                   },
                   trailing: Button("Сохранить") {
                       saveTest()
                   }
               )
               .navigationTitle(test != nil ? "Редактировать Тест" : "Добавить Тест")
               .onAppear {
                   if let test = test {
                       self.title = test.title ?? ""
                       if let questionSet = test.questions as? Set<Question> {
                           let questions = Array(questionSet)
                       }
                   } else {
                       addQuestion()
                   }
               }
           }
       }

  
    private func addQuestion() {
        let answer1 = Answer(text: "Ответ 1", isCorrect: false)
        let answer2 = Answer(text: "Ответ 2", isCorrect: false)
        let answer3 = Answer(text: "Ответ 3", isCorrect: false)
        let answer4 = Answer(text: "Ответ 4", isCorrect: false)
        let question = Question(text: "Новый вопрос", answers: [answer1, answer2, answer3, answer4])
        
        questions.append(question)
    }


    private func saveTest() {
        if title.isEmpty {
            print("Название не может быть пустым")
            return
        }
        
        for question in questions {
            if question.text.isEmpty || question.answers.contains(where: { $0.text.isEmpty }) {
                print("Вопрос и ответы не могут быть пустыми")
                return
            }
        }
        
        let testToSave: Quiz
        if let testIndex = testIndex {
            testToSave = testStore.tests[testIndex]
        } else {
            testToSave = Quiz(title: title, questions: questions)
            testStore.addTest(test: testToSave)
        }
        testToSave.title = title
        testToSave.questions = questions
        
        self.presentationMode.wrappedValue.dismiss()
    }
}
