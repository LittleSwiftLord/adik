//
//  AddReferenceView.swift
//  MCHSHandbook
//
//  Created by Aidar Satindiev on 17/4/23.
//

import Foundation
import SwiftUI
import CoreData

struct AddReferenceView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    var article: ReferenceArticle? // Добавленная строка
    
    @State private var title: String = ""
    @State private var content: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Название", text: $title)
                    TextEditor(text: $content)
                        .frame(minHeight: 200) // Увеличение высоты TextEditor
                }
            }
            .navigationTitle(article == nil ? "Добавить справочник" : "Редактировать справочник") // Измененная строка
            .navigationBarItems(trailing: Button("Сохранить") {
                saveReference()
            })
        }
        .onAppear {
            if let existingArticle = article {
                title = existingArticle.title ?? ""
                content = existingArticle.content ?? ""
            }
        }
    }
    
    private func saveReference() {
        guard let article = article else {
            createNewReference()
            return
        }
        
        article.title = title
        article.content = content
        
        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Ошибка сохранения справочной информации: \(error)")
        }
    }
    
    private func createNewReference() {
        let newReference = ReferenceArticle(context: viewContext)
        newReference.id = UUID()
        newReference.title = title
        newReference.content = content
        
        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Ошибка сохранения справочной информации: \(error)")
        }
    }
}
