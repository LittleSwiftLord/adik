//
//  ReferenceListView.swift
//  MCHSHandbook
//
//  Created by Aidar Satindiev on 17/4/23.
//
import SwiftUI
import CoreData

struct ReferenceItem: Codable {
    let title: String
    let description: String
}

struct ReferenceListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: ReferenceArticle.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ReferenceArticle.title, ascending: true)]) var articles: FetchedResults<ReferenceArticle>
    
    @EnvironmentObject var sessionManager: SessionManager
    @State private var showAddReferenceView = false
    @State private var referenceItems: [ReferenceItem] = []
    @State private var isEditing = false // Добавленная строка
    
    var body: some View {
        NavigationView {
            List {
                ForEach(articles) { article in
                    NavigationLink(destination: ReferenceArticleView(article: article)) {
                        Text(article.title ?? "")
                    }
                }
                .onDelete(perform: deleteArticle)
            }
            .navigationTitle("Справочник")
            .navigationBarItems(
                trailing: sessionManager.currentUser?.isAdmin == true ?
                    Button(action: {
                        showAddReferenceView = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showAddReferenceView) {
                        AddReferenceView()
                            .environment(\.managedObjectContext, viewContext)
                            .onDisappear {
                                do {
                                    try viewContext.save()
                                } catch {
                                    print("Ошибка сохранения контекста: \(error)")
                                }
                            }
                    }
                    : nil
            )
            .toolbar { // Добавленный блок
                ToolbarItem(placement: .navigationBarTrailing) {
                  
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    if isEditing {
                        Button("Готово") {
                            isEditing.toggle()
                        }
                    }
                }
            }
            .environment(\.editMode, .constant(isEditing ? EditMode.active : EditMode.inactive)) // Измененная строка
        }
        .onAppear {
            loadReferenceItems()
        }
    }
    
    
    func loadReferenceItems() {
        guard let fileURL = Bundle.main.url(forResource: "reference_data", withExtension: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            referenceItems = try decoder.decode([ReferenceItem].self, from: data)
        } catch {
            print("Ошибка загрузки справочной информации: \(error)")
        }
    }
    
    private func deleteArticle(at offsets: IndexSet) {
        for index in offsets {
            let article = articles[index]
            viewContext.delete(article)
        }
        
        do {
            try viewContext.save()
        } catch {
            print("Ошибка сохранения контекста: \(error)")
        }
    }
}

