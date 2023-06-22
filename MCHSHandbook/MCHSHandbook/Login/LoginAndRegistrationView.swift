
import SwiftUI

struct LoginAndRegistrationView: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @State private var isRegistration = false
    
    var body: some View {
        VStack {
            if isRegistration {
                Text("Регистрация")
                    .font(.largeTitle)
            } else {
                Text("Вход")
                    .font(.largeTitle)
            }
            
            VStack {
                TextField("Имя пользователя", text: $username)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                
                SecureField("Пароль", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                
                if isRegistration {
                    SecureField("Подтвердите пароль", text: $confirmPassword)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(5)
                }
            }.padding(.horizontal)
            
            Button(action: {
                if isRegistration {
                    if sessionManager.register(username: username, password: password, confirmPassword: confirmPassword) {
                        sessionManager.login(username: username, password: password)
                    } else {
                        print("Ошибка при регистрации")
                    }
                } else {
                    if sessionManager.login(username: username, password: password) {
                        print("Успешный вход")
                    } else {
                        print("Ошибка при входе")
                    }
                }
            }) {
                Text(isRegistration ? "Зарегистрироваться" : "Войти")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(5)
            }
            .padding(.horizontal)
            
            Button(action: {
                isRegistration.toggle()
            }) {
                Text(isRegistration ? "Уже зарегистрированы? Войти" : "Нет аккаунта? Зарегистрироваться")
            }
            .padding(.top)
        }
    }
}

