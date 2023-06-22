

import Foundation
import SwiftUI

struct ReferenceArticleView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    @Environment(\.managedObjectContext) private var viewContext
    
    let article: ReferenceArticle
    @State private var isEditing = false
    @State private var editedTitle: String
    @State private var editedContent: String
    
    init(article: ReferenceArticle) {
        self.article = article
        self._editedTitle = State(initialValue: article.title ?? "")
        self._editedContent = State(initialValue: article.content ?? "")
    }
    
    var body: some View {
        VStack {
            if isEditing {
                TextField("Название", text: $editedTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextEditor(text: $editedContent)
                    .padding()
            } else {
                Text(article.title ?? "")
                    .font(.title)
                    .bold()
                    .padding()
                
                ScrollView {
                    Text(article.content ?? "")
                        .padding()
                }
            }
            
            if sessionManager.currentUser?.isAdmin == true {
                if isEditing {
                    HStack {
                        Button(action: {
                            saveChanges()
                        }) {
                            Text("Сохранить")
                        }
                        .padding()
                        
                        Button(action: {
                            cancelEditing()
                        }) {
                            Text("Отменить")
                        }
                        .padding()
                    }
                } else {
                    Button(action: {
                        startEditing()
                    }) {
                        Text("Редактировать")
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Статья")
    }

    private func startEditing() {
        isEditing = true
    }
    
    private func cancelEditing() {
        isEditing = false
        editedTitle = article.title ?? ""
        editedContent = article.content ?? ""
    }
    
    private func saveChanges() {
        article.title = editedTitle
        article.content = editedContent
        
        do {
            try viewContext.save()
            isEditing = false
        } catch {
            print("Ошибка сохранения справочной информации: \(error)")
        }
    }
}
