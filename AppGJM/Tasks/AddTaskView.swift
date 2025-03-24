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
    
    @State var selectedPriority: TaskModel.TaskPriority? = nil
    @State var taskName: String = ""
    @State var taskDate: Date = Date()
    @State var isDone: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Nome") .font(Font.custom("SF Pro", size: 18))
                    .foregroundColor(.black)
                    .frame(width: 323, alignment: .leading)) {
                    TextField("Nome da Tarefa", text: $taskName)
                    
                }
                
                Section(header: Text("Prioridade da Tarefa")) {
                    Picker("Prioridade", selection: $selectedPriority) {
                        ForEach(TaskModel.TaskPriority.allCases, id: \.self) { priority in
                            Text(priority.rawValue).tag(priority as TaskModel.TaskPriority?)
                        }
                    }
                }
                
                .keyboardType(.numberPad)
                
            }
            .navigationTitle("Adicionar Tarefas")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancelar").fontWeight(.medium)
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Adicionar").fontWeight(.medium)
                    }
                }
            }
            
        }
    }
}

#Preview {
    AddTaskView()
}
