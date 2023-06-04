//  NewToDoView.swift
//  ToDoApp
//  Created by Sanjida Orpi.

import SwiftUI

struct NewToDoView: View {
    @Environment(\.managedObjectContext) var context
    
    @Binding var title: String
    @Binding var isImportant: Bool
    @Binding var showNewTask: Bool
    
    var body: some View {
        VStack {
            Text("Add a new task")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            TextField("Enter the task description", text: $title)
                .padding()
                .background(Color(.systemGroupedBackground))
                .cornerRadius(15)
                .padding()
            
            Toggle(isOn: $isImportant) {
                            Text("Is it important?")
                                .font(.system(size: 20))
                        }
                        .padding()

                        Button(action: {
                            self.showNewTask = false
                            self.addTask(title: self.title, isImportant: self.isImportant)
                
                        }) {
                            Text("Add")

                        }
                        .padding()
                        

                    }
                }
                private func addTask(title: String, isImportant: Bool = false) {
                    
                    let task = ToDo(context: context)
                    task.id = UUID()
                    task.title = title
                    task.isImportant = isImportant
                    
                    do {
                        try context.save()
                    } catch {
                        print(error)
                    }
                }
            }

