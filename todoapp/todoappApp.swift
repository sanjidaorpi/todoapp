//
//  todoappApp.swift
//  todoapp
//  Created by Sanjida Orpi.
//

import SwiftUI

@main
struct toDoListForLessonApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
