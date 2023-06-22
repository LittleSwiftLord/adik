import SwiftUI
import CoreData

struct TestListView: View {
    @ObservedObject var testStore: TestStore

    var body: some View {
        NavigationView {
            List {
                ForEach(testStore.tests.indices, id: \.self) { index in
                    NavigationLink(destination: AddEditTestView(testStore: testStore, testIndex: index)) {
                        Text(testStore.tests[index].title)
                    }
                }
                .onDelete(perform: deleteTests)
            }
            .navigationBarTitle("Тесты")
            .navigationBarItems(
                trailing: NavigationLink(destination: AddEditTestView(testStore: testStore)) {
                    Image(systemName: "plus")
                }
            )
        }
    }

    private func deleteTests(at offsets: IndexSet) {
        for index in offsets {
            testStore.removeTest(test: testStore.tests[index])
        }
    }
}
