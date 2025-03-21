//
//  TasksView.swift
//  AppGJM
//
//  Created by user on 20/03/25.
//

import SwiftUI
import SwiftData

struct AddTaskView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State var taskName: String = ""
    @State var taskDate: Date = Date()
    @State var isDone: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Nome da tarefa", text: $taskName)
                DatePicker("Data", selection: $taskDate)
                Toggle("Alarme", isOn: $isDone)
                
            }
            
        }
    }
}

#Preview {
    AddTaskView()
}
