//
//  ToDoListView.swift
//  ToDoListView
//
//  Created by Iain Studio on 4/1/2025.
//

import SwiftUI
import SwiftData

struct ToDoListView: View {
  
    var toDos = ["Learn Swift",
                 "Build Apps",
                 "Change the World",
                 "Bring the Awesome",
                "Take a Holiday"]

//    var toDos = [ToDo(item: "Learn Swift"),
//                 ToDo(item: "Build Apps"),
//                 ToDo(item: "Change the World"),
//                 ToDo(item: "Bring the Awesome")]
    
    @State private var sheetIsPresented = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(toDos, id: \.self) { toDo in
                    NavigationLink {
                        DetailView1(passedValue: toDo)
                    } label: {
                        Text(toDo)
                    }
                    .font(.title2)
                }
            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
            .sheet(isPresented: $sheetIsPresented) {
                NavigationStack {
                    DetailView(toDo: ToDo())
                }
                
            }
        }
    }
}

#Preview {
    NavigationStack {
        ToDoListView()
            .modelContainer(for: ToDo.self, inMemory: true)
    }
}
