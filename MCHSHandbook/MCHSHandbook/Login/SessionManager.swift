
import SwiftUI
import Combine

class SessionManager: ObservableObject {
    @Published var currentProfile: Profile?
    @Published var currentUser: User?
    private var persistenceController = PersistenceController.shared

    // Вход пользователя
    func login(username: String, password: String) -> Bool {
        if let user = persistenceController.checkUserCredentials(username: username, password: password) {
            currentUser = user
            return true
        } else {
            return false
        }
    }

    func logout() {
        currentUser = nil
    }

    // Регистрация нового пользователя
    func register(username: String, password: String, confirmPassword: String) -> Bool {
        if password == confirmPassword {
            let isCreated = persistenceController.createUser(username: username, password: password)
            if isCreated {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}
