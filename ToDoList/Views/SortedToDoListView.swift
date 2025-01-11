//
//  SortedToDoListView.swift
//  ToDoList
//
//  Created by Iain Studio on 10/1/2025.
//

import SwiftUI
import SwiftData

struct SortedToDoList: View {
    @Query(sort: \ToDo.dueDate) var toDos: [ToDo] = []
    @Environment(\.modelContext) var modelContext
    
    let sortOption: SortOption
    
    init(sortOption: SortOption) {
        self.sortOption = sortOption
        switch self.sortOption {
            case .asEntered:
                _toDos = Query()
            case .alphabetical:
                _toDos = Query(sort: \.item)
            case .chronological:
                _toDos = Query(sort: \.dueDate)
            case .completed:
                _toDos = Query(filter: #Predicate {$0.isCompleted == false}, sort: \.dueDate)
        }
        
    }
    
    var body: some View {
        List {
            ForEach(toDos) { toDo in
                //                ForEach(toDos, id: \.self) { toDo in  // not required with SwiftData as each item has a unique Id.
                VStack (alignment: .leading){
                    HStack {
                        Image(systemName: toDo.isCompleted ? "checkmark.rectangle" : "rectangle")
                            .onTapGesture {
                                toDo.isCompleted.toggle()
                                guard let _ = try? modelContext.save() else {
                                    fatalError("😡 ERROR: Failed to save changes on Toggle in ToDoListView")
                                }
                            }
                        NavigationLink {
                            DetailView(toDo: toDo)
                        } label: {
                            Text(toDo.item)
                        }
                        .swipeActions {
                            Button("Delete", role: .destructive) {
                                modelContext.delete(toDo)
                                //  The following is to force a save rather than waiting for ther timeout
                                guard let _ = try? modelContext.save() else {
                                    fatalError("😡 ERROR: Failed to save changes on Delete")
                                }
                            }
                        }
                    }
                    .font(.title2)
                    
                    HStack {
                        Text(toDo.dueDate.formatted(date: .abbreviated, time: .shortened))
                            .foregroundStyle(.secondary)
                        if toDo.reminderIsOn {
                            Image(systemName: "calendar.badge.clock")
                                .symbolRenderingMode(.multicolor)
                        }
                    }
                }
            }
            //  Either the following ".onDelete or the above "swipeActions" will both perform a delete...the below would allow for a multi item delete
            //                .onDelete { indexSet in
            //                    indexSet.forEach { modelContext.delete(toDos[$0]) }
            ////   The following is to force a save rather than waiting for ther timeout
            //                    guard let _ = try? modelContext.save() else {
            //                        fatalError("😡 ERROR: Failed to save changes on Delete") }
            //                }
        }
        .listStyle(.plain)
        
    }
}
