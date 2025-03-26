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
    
    @State private var selectedDay = "D"
    
    // Dias no formato personalizado
    let days = ["D", "S", "T", "Q", "Q", "S", "S"]
    
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
                    if task.days == .specificDays {
                        Picker("Selecione o Dia", selection: $selectedDay) {
                            ForEach(days, id: \.self) { day in
                                Text(day)
                                    .font(.title2)
                                    .padding()
                                    .frame(width: 50, height: 50)
                                    .background(Circle().fill(Color.blue.opacity(0.2)))
                                    .cornerRadius(25)
                                    .foregroundColor(.blue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal, 20)
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
