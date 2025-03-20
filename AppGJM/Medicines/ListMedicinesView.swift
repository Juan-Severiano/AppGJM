//
//  ListMedicinesView.swift
//  AppGJM
//
//  Created by Francisco Juan on 20/03/25.
//

import SwiftUI
import SwiftData

struct ListMedicinesView: View {
    @Query var medicines: [MedicineModel]
    @State var search: String = ""
    
    @State var addMedicine: Bool = false
    
    var body: some View {
        NavigationStack {
            if medicines.isEmpty {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.gray)
                    .frame(maxWidth: 300, maxHeight: 300)
                Text("Você ainda não tem medicamentos adicionados")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                
                Text("Aperte no botão abaixo para adicionar algum medicamento")
                    .multilineTextAlignment(.center)
                
                HStack {
                    Button {
                        addMedicine.toggle()
                    } label: {
                        Label {
                            Text("Adicionar")
                        } icon: {
                            Image(systemName: "plus")
                        }
                        .frame(width: 150)
                        
                    }
                    .padding(10)
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .containerShape(.capsule)
                }
            } else {
                List {
                    ForEach(medicines.filter { search.isEmpty || $0.name.localizedCaseInsensitiveContains(search) }) { medicine in
                        MedicineView(medicine: medicine)
                            .swipeActions(edge: .leading) {
                                Button {
                                    medicine.takeDose()
                                } label: {
                                    Image(systemName: "checkmark.arrow.trianglehead.counterclockwise")
                                }
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(role: .destructive) {
                                    medicine.takeDose()
                                } label: {
                                    Image(systemName: "trash")
                                }
                                Button {
                                    medicine.takeDose()
                                } label: {
                                    Image(systemName: "pencil.and.scribble")
                                }
                                .background(Color.blue)
                            }
                            .contextMenu {
                                Button {
                                    medicine.takeDose()
                                } label: {
                                    Label("Tomar medicamento",systemImage: "checkmark.arrow.trianglehead.counterclockwise")
                                }
                                Button {
                                    medicine.takeDose()
                                } label: {
                                    Label("Editar",systemImage: "pencil.and.scribble")
                                }
                                Button(role: .destructive) {
                                    medicine.takeDose()
                                } label: {
                                    Label("Apagar",systemImage: "trash")
                                }
                            }
                    }
                    .listStyle(.plain)
                }
            }
            VStack {
                Text("")
            }
            .sheet(isPresented: $addMedicine) {
                AddMedicineView()
            }
            .navigationTitle("Meus Medicamentos")
            .searchable(text: $search)
            .disabled(medicines.isEmpty)
            .toolbar {
                ToolbarItem(
                    placement: .confirmationAction
                ) {
                    Button {
                        addMedicine.toggle()
                    } label: {
                        Text("Adicionar")
                        Image(
                            systemName:
                                "plus"
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    ListMedicinesView()
}
