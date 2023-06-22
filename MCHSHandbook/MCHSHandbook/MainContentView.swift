

import SwiftUI

struct MainContentView: View {
    @EnvironmentObject var sessionManager: SessionManager

    var body: some View {
        NavigationView {
            TabView {
                ReferenceListView()
                    .tabItem {
                        Image(systemName: "book")
                        Text("Справочник")
                    }

                let myTestStore = TestStore()
                TestListView(testStore: myTestStore)
                    .tabItem {
                        Image(systemName: "checkmark.square")
                        Text("Тесты")
                    }

                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Профиль")
                    }
            }
            .navigationBarItems(trailing: logoutButton)
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var logoutButton: some View {
        Button(action: {
            sessionManager.logout()
        }) {
            Image(systemName: "arrow.right.circle.fill")
                .resizable()
                .frame(width: 24, height: 24)
        }
    }
}
