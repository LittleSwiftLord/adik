import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
            container = NSPersistentContainer(name: "MCHSHandbook")
            if inMemory {
                container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
            }
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            checkForAdmin()
        }
    func checkForAdmin() {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isAdmin == true")

        do {
            let admins = try context.fetch(fetchRequest)
            if admins.isEmpty {
                createAdmin()
            }
        } catch {
            print("Ошибка при проверке наличия администратора: \(error)")
        }
    }

    func createAdmin() {
        let context = container.viewContext
        let admin = User(context: context)
        admin.id = UUID()
        admin.username = "admin"
        admin.password = "admin123"
        admin.isAdmin = true

        try? context.save()
    }


    // Поиск пользователя по имени пользователя
    func fetchUser(username: String) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "username == %@", username)

        do {
            let users = try container.viewContext.fetch(request)
            return users.first
        } catch {
            print("Ошибка при поиске пользователя: \(error)")
            return nil
        }
    }

    // Метод для создания нового пользователя
    func createUser(username: String, password: String, isAdmin: Bool = false) -> Bool {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)

        do {
            let users = try context.fetch(fetchRequest)
            if users.isEmpty {
                let newUser = User(context: context)
                newUser.id = UUID()
                newUser.username = username
                newUser.password = password
                newUser.isAdmin = isAdmin

                try context.save()
                return true
            } else {
                return false
            }
        } catch {
            print("Error creating user: \(error.localizedDescription)")
            return false
        }
    }

    // Метод для проверки данных пользователя при входе
    func checkUserCredentials(username: String, password: String) -> User? {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)

        do {
            let users = try context.fetch(fetchRequest)
            if let user = users.first {
                return user
            } else {
                return nil
            }
        } catch {
            print("Error checking user credentials: \(error.localizedDescription)")
            return nil
        }
    }
    
}
