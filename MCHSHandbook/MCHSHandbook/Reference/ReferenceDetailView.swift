

import SwiftUI

struct ReferenceDetailView: View {
    var reference: Reference
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(reference.title ?? "")
                    .font(.title)
                
                Text(reference.content ?? "")
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // Задаем максимальные размеры компонента
                
                // Дополнительные компоненты в справочной информации
            }
            .padding()
        }
    }
}
