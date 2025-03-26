//
//  EditMedicineView.swift
//  AppGJM
//
//  Created by Francisco Juan on 20/03/25.
//

import SwiftUI

struct EditMedicineView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State var hasNoName: Bool = false
    
    @State var medicine: MedicineModel
    
    func isSpecificDays() -> Bool {
        return medicine.days == .specificDays
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Image("add-medicine")
                    .containerRelativeFrame(.horizontal)
                    .listRowBackground(Color.clear)
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
                    if isSpecificDays() {
                        Filter(selection: $medicine.specificDays) {
                            ForEach(SpecificDays.allCases, id: \.self) { value in
                                Text(String(value.rawValue.first!))
                                    .padding(6)
                                    .foregroundStyle(medicine.specificDays.contains(value.rawValue) ? Color.white : Color.primary)
                                    .frame(width: 40)
                                    .background {
                                        if medicine.specificDays.contains(value.rawValue) {
                                            Circle()
                                                .fill(.button)
                                        }
                                    }
                                    .onTapGesture {
                                        if medicine.specificDays.contains(value.rawValue) {
                                            medicine.specificDays.remove(value.rawValue)
                                        } else {
                                            medicine.specificDays.insert(value.rawValue)
                                        }
                                    }
                            }
                        }
                    }
                    Picker("Repetição", selection: $medicine.repetition) {
                        ForEach(Repetition.allCases, id: \.self) { format in
                            Text(format.rawValue)
                        }
                    }
                    DatePicker("Horário de Início", selection: $medicine.firstMedicineHour, displayedComponents: .hourAndMinute)
                    Toggle(isOn: $medicine.alarm) {
                        Text("Alarme")
                    }
                    .tint(.button)
                }
            }
            .background(Color.white)
            .navigationTitle("Editar Medicamento")
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
    EditMedicineView(
        medicine: MedicineModel(name: "", quantity: 1, typeOfMedicine: .mg, format: .comprimido, alarm: false, firstTime: Date(), repetition: .every4Hours, firstMedicineHour: Date(), purpose: "", days: .specificDays)
    )
}
