//
//  AddMedicineView.swift
//  AppGJM
//
//  Created by Geovana on 20/03/25.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State var hasNoName: Bool = false
    
    @State var task = TaskModel(id: <#T##UUID#>, tittle: <#T##String#>, date: <#T##Date#>, priority: <#T##TaskModel.TaskPriority#>)
    
    var body: some View {
        NavigationStack {
            Image("add-medicine")
            Form {
                Section(header: Text("Nome")) {
                    TextField(text: $medicine.name) {
                        Text("Nome do Medicamento")
                    }
                }
                
                Section(header: Text("Dose")) {
                    Picker("Formato", selection: $medicine.format) {
                        ForEach(Formats.allCases, id: \.self) { format in
                            Text(format.rawValue)
                        }
                    }
                    HStack {
                        Stepper("Valor da Dose", value: $medicine.quantity, in: 0...1000)
                        Text("\(medicine.quantity)")
                    }
                    Picker("Unidade de Medida", selection: $medicine.typeOfMedicine) {
                        ForEach(TypeOfMedicine.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                }
                
                Section(header: Text("Dosagem(frequência)")) {
                    Picker("Dias", selection: $medicine.days) {
                        ForEach(Days.allCases, id: \.self) { format in
                            Text(format.rawValue)
                        }
                    }
                    if medicine.days == .specificDays {
                        Text("dsfsdf")
                    }
                    Picker("Repetição", selection: $medicine.repetition) {
                        ForEach(Repetition.allCases, id: \.self) { format in
                            Text(format.rawValue)
                        }
                    }
                    DatePicker("Horário de Início", selection: $medicine.firstMedicineHour, displayedComponents: .hourAndMinute)
                }
                
                Section(header: Text("Adicionar Alarme")) {
                    Toggle(isOn: $medicine.alarm) {
                        Text("Alarme")
                    }
                }
            }
            .background(Color.white)
            .navigationTitle("Adicionar Medicamento")
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
                        self.addMedicine(medicine)
                    } label: {
                        Text("Seguinte")
                    }
                }
            }
        }
    }
    func addMedicine(_ medicine: MedicineModel) {
        modelContext.insert(medicine)
        dismiss()
    }
}

#Preview {
    AddMedicineView()
}
