//
//  MyWorldApp.swift
//  MyWorld
//
//  Created by pc on 06/05/2023.
//

import SwiftUI

@main
struct MyWorldApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
