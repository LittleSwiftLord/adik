import SwiftUI
import CoreData

struct AddTestView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext

    @State private var title: String = ""
    @State private var questions: [Question] = []

    var body: some View {
        let myTestStore = TestStore()
        AddEditTestView(testStore: myTestStore)

            .environment(\.managedObjectContext, viewContext)
    }
}
