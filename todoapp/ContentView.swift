//  ContentView.swift
//  ToDoApp
//  Created by Sanjida Orpi.

import SwiftUI
import CoreData


struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(
            entity: ToDo.entity(), sortDescriptors: [ NSSortDescriptor(keyPath: \ToDo.id, ascending: false) ])
        
    var toDoItems: FetchedResults<ToDo>
    
    @State private var showNewTask = false
    @State private var newToDoTitle = ""
    @State private var newToDoIsImportant = false
    
    let persistenceController = PersistenceController.shared
    
    var body: some View {
        VStack {
            HStack {
                Text("To Do List")
                     .font(.system(size: 40))
                     .fontWeight(.black)
                
                Button(action: {
                    self.showNewTask = true
                }) {
                    Text("+")
                }
            }
            .padding()
            
            List {
                ForEach(toDoItems) { toDoItem in
                    if toDoItem.isImportant == true {
                        Text("‼️" + (toDoItem.title ?? "No title"))
                    } else {
                        Text(toDoItem.title ?? "No title")
                    }
                }
                .onDelete(perform: deleteTask)
                .padding()
            }
            .listStyle(.plain)
        }
        .sheet(isPresented: $showNewTask) {
            NewToDoView(
                title: $newToDoTitle,
                isImportant: $newToDoIsImportant,
                showNewTask: $showNewTask
            )
        }
    }
    
    private func deleteTask(offsets: IndexSet) {
            withAnimation {
                offsets.map { toDoItems[$0] }.forEach(context.delete)

                do {
                    try context.save()
                } catch {
                    print(error)
                }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static let persistenceController = PersistenceController.shared
    
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}
