//
//  RegistrationView.swift
//  MCHSHandbook
//
//  Created by Aidar Satindiev on 17/4/23.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @Environment(\.presentationMode) var presentationMode
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var navigateToLogin: Bool = false

    var body: some View {
        VStack {
            Text("Регистрация")
                .font(.largeTitle)
                .padding()

            TextField("Логин", text: $username)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Пароль", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Подтвердите пароль", text: $confirmPassword)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Зарегистрироваться") {
                register()
            }
            .padding()
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK"), action: {
                if navigateToLogin {
                    presentationMode.wrappedValue.dismiss()
                }
            }))
        }
    }

    private func register() {
        let registered = sessionManager.register(username: username, password: password, confirmPassword: confirmPassword)
        if registered {
            // Уведомление об успешной регистрации
            alertTitle = "Успешно"
            alertMessage = "Пользователь успешно зарегистрирован"
            navigateToLogin = true
        } else {
            // Отобразите сообщение об ошибке, если регистрация не удалась
            alertTitle = "Ошибка"
            alertMessage = "Регистрация не удалась. Пожалуйста, проверьте введенные данные."
            navigateToLogin = false
        }
        showAlert = true
    }
}
