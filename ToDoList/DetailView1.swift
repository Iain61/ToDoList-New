//
//  DetailView1.swift
//  ToDoList
//
//  Created by Iain Studio on 7/1/2025.
//

import SwiftUI

struct DetailView1: View {
    @Environment(\.dismiss) private var dismiss
    
    var passedValue: String
    
    var body: some View {
        VStack {
            Image(systemName: "swift")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.orange)
            
            Text("You are a swift legend!\n \(passedValue)")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button("Get Back") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
//        .navigationBarBackButtonHidden()
    }
}

#Preview {
    DetailView1(passedValue: "Hello World!")
}
