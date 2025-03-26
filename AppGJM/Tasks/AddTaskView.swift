//
//  AddTaskView.swift
//  AppGJM
//
//  Created by Geovana on 20/03/25.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State var hasNoName: Bool = false
    
    @State var task: TaskModel = TaskModel(name: "", priority: .routine, hasAlarm: false, days: .everyDay, activity: .cleaning, hour: Date(), isDone: false)
    
    func isSpecificDays() -> Bool {
        return task.days == .specificDays
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Image("add-task")
                    .containerRelativeFrame(.horizontal)
                    .listRowBackground(Color.clear)

                Section(header: Text("Nome da tarefa")) {
                    TextField(text: $task.name) {
                        Text("Nome da Tarefa")
                    }
                }
                
                Section(header: Text("Informações da Tarefa")) {
                    Picker("Prioridade", selection: $task.priority) {
                        ForEach(Priority.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                    Picker("Atividades", selection: $task.activity) {
                        ForEach(Activity.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                }
                
                Section(header: Text("Frequência"), footer: Text("Adicionando o alarme, você garante mais segurança para realizar a tarefa e manter uma boa rotina para o idoso")) {
                    Picker("Dias", selection: $task.days) {
                        ForEach(Days.allCases, id: \.self) { format in
                            Text(format.rawValue)
                        }
                    }
                    if isSpecificDays() {
                        Filter(selection: $task.specificDays) {
                            ForEach(SpecificDays.allCases, id: \.self) { value in
                                Text(String(value.rawValue.first!))
                                    .padding(6)
                                    .foregroundStyle(task.specificDays.contains(value.rawValue) ? Color.white : Color.primary)
                                    .frame(width: 40)
                                    .background {
                                        if task.specificDays.contains(value.rawValue) {
                                            Circle()
                                                .fill(.black.opacity(0.8))
                                        }
                                    }
                                    .onTapGesture {
                                        if task.specificDays.contains(value.rawValue) {
                                            task.specificDays.remove(value.rawValue)
                                        } else {
                                            task.specificDays.insert(value.rawValue)
                                        }
                                    }
                            }
                        }
                    }
                    Toggle(isOn: $task.hasAlarm) {
                        Text("Alarme")
                    }
                    DatePicker("Hora", selection: $task.hour, displayedComponents: .hourAndMinute)
                }
            }
            .background(Color.white)
            .navigationTitle("Adicionar Tarefa")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancelar")
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        self.addTask(task)
                    } label: {
                        Text("Adicionar")
                    }
                }
            }
        }
    }
    func addTask(_ task: TaskModel) {
        modelContext.insert(task)
        dismiss()
    }
}

#Preview {
    AddTaskView()
}
