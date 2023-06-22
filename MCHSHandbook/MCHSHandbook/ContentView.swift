//
//  ContentView.swift
//  MCHSHandbook
//
//  Created by Aidar Satindiev on 17/4/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var sessionManager = SessionManager()

    var body: some View {
        NavigationView {
            if sessionManager.currentUser != nil {
                MainContentView()
            } else {
                LoginView()
            }
        }
        .environmentObject(sessionManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

