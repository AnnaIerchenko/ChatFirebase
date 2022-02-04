//
//  ChatFirebaseApp.swift
//  ChatFirebase
//
//  Created by Ierchenko Anna  on 1/31/22.
//

import SwiftUI
import Firebase

@main
struct ChatFirebaseApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
