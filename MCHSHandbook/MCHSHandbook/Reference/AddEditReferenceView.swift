//
//  AddEditReferenceView.swift
//  MCHSHandbook
//
//  Created by Aidar Satindiev on 17/4/23.
//

import SwiftUI

struct AddEditReferenceView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    var reference: Reference? = nil
    @Binding var articles: Set<ReferenceArticle>

    @State private var title: String = ""
    @State private var content: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Название", text: $title)
                    TextEditor(text: $content)
                }
            }
            .navigationTitle(reference == nil ? "Добавить справочник" : "Редактировать справочник")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: saveReference) {
                        Text("Сохранить")
                    }
                }
            }
        }
        .onAppear {
            if let reference = reference {
                title = reference.title ?? ""
                content = reference.content ?? ""
            }
        }
    }

    private func saveReference() {
        let articleArray = Array(articles)
        if let reference = reference {
            reference.title = title
            reference.content = content
            
        } else {
            let newReference = Reference(context: viewContext)
            newReference.id = UUID()
            newReference.title = title
            newReference.content = content
        }

        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Ошибка сохранения справочной информации: \(error)")
        }
    }
}
