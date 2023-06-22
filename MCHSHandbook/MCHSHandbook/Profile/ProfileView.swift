import SwiftUI
import CoreData
import Foundation

struct ProfileView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State private var newPassword: String = ""
    
    var body: some View {
        VStack {
            Image("2") // Замените "profileImage" на имя вашего изображения
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .padding()
            
            Text("Логин: 111\(sessionManager.currentProfile?.username ?? "")")
                .font(.title)
            
            Divider()
            
            VStack(spacing: 20) {
                SecureField("Новый пароль", text: $newPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    changePassword()
                }) {
                    Text("Сменить пароль")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationBarTitle("Профиль")
    }
    
    
    private func changePassword() {
        if var profile = sessionManager.currentProfile {
            profile.password = newPassword
            sessionManager.currentProfile = profile
        }
        // Очистить поле нового пароля после изменения
        newPassword = ""
    }
}
