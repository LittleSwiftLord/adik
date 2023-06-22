//
//  MCHSHandbookApp.swift
//  MCHSHandbook
//
//  Created by Aidar Satindiev on 17/4/23.
//

import SwiftUI

@main
struct MCHSHandbookApp: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject private var sessionManager = SessionManager()

    var body: some Scene {
        WindowGroup {
            if let user = sessionManager.currentUser {
                MainContentView()
                    .environmentObject(sessionManager)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            } else {
                LoginAndRegistrationView()
                    .environmentObject(sessionManager)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}

