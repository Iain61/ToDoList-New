//
//  ToDoListView.swift
//  ToDoListView
//
//  Created by Iain Studio on 4/1/2025.
//

import SwiftUI
import SwiftData

//....moved to seperate file "SortOption"
//enum SortOption: String, CaseIterable {
//    case asEntered = "As Entered"
//    case alphabetical = "A-Z"
//    case chronological = "Date"
//    case completed = "Not Done"
//}

struct ToDoListView: View {
    @State private var sheetIsPresented = false
    @State private var sortOption: SortOption = .asEntered
    
    var body: some View {
        NavigationStack {
            SortedToDoList(sortOption: sortOption)
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Picker("", selection: $sortOption) {
                        ForEach(SortOption.allCases, id: \.self) { sortOrder in
                            Text(sortOrder.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .sheet(isPresented: $sheetIsPresented) {
                NavigationStack {
                    DetailView(toDo: ToDo())
//                    DetailView(toDo: "")
                }
            }
        }
    }
}
// Note the preview mock data is created in the class definition.
#Preview {
    NavigationStack {
        ToDoListView()
            .modelContainer(ToDo.preview)
    }
}
