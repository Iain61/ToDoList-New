//
//  ToDo.swift
//  ToDoList
//
//  Created by Iain Studio on 4/1/2025.
//

import Foundation
import SwiftData

@MainActor
@Model
class ToDo {
    var item: String = ""
    var reminderIsOn = false
    var dueDate = Date.now + 60*60*24
    var notes = ""
    var isCompleted = false
    
    init(item: String = "", reminderIsOn: Bool = false, dueDate: Date = Date.now + 60*60*24, notes: String = "", isCompleted: Bool = false) {
        self.item = item
        self.reminderIsOn = reminderIsOn
        self.dueDate = dueDate
        self.notes = notes
        self.isCompleted = isCompleted
    }
}

extension ToDo {
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: ToDo.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        // Add preview example data
        container.mainContext.insert(ToDo(item: "Create SwiftData", reminderIsOn: true, dueDate: Date.now + 60*60*24, notes: "Now with iOS 18", isCompleted: false))
        container.mainContext.insert(ToDo(item: "Bake a cake", reminderIsOn: true, dueDate: Date.now + 4*60*60*24, notes: "Needs to be chocolate", isCompleted: true))
        container.mainContext.insert(ToDo(item: "Visit Benny", reminderIsOn: true, dueDate: Date.now + 2*60*60*24, notes: "Take Puppo with you", isCompleted: false))
        container.mainContext.insert(ToDo(item: "Visit playground", reminderIsOn: true, dueDate: Date.now + 60*60*24, notes: "Try the new timber playground", isCompleted: false))
        container.mainContext.insert(ToDo(item: "Post flyers on social media", reminderIsOn: true, dueDate: Date.now + 5*60*60*24, notes: "Use #SwiftData", isCompleted: true))
        
        return container
    }
}
