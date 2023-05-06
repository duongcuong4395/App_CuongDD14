//
//  MyWorldApp.swift
//  MyWorld
//
//  Created by pc on 06/05/2023.
//

import SwiftUI
import Firebase

@main
struct MyWorldApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
