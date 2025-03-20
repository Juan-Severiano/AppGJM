//
//  AddMedicineView.swift
//  AppGJM
//
//  Created by user on 20/03/25.
//

import SwiftUI

struct AddMedicineView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State var name: String = ""
    
    var body: some View {
        NavigationStack {
            Text("Qual é o medicamento?")
                .font(.title)
                .fontWeight(.bold)
                .dynamicTypeSize(.xxxLarge)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 300)
            Form {
                TextField(text: $name) {
                    Text("Nome do Medicamento")
                }
                TextField(text: $name) {
                    Text("Formato")
                }
                TextField(text: $name) {
                    Text("Dose")
                }
                .keyboardType(.numberPad)
            }
            HStack {
                Button {
                    
                } label: {
                    Text("Seguinte")
                        .frame(maxWidth: 300)
                }
                .buttonStyle(.borderedProminent)
                .tint(.pink)
            }

            .navigationTitle("Adicionar Medicamento")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancelar").fontWeight(.medium)
                    }
                }
            }
        }
    }
}

#Preview {
    AddMedicineView()
}
