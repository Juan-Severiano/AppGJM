//
//  ListMedicinesView.swift
//  AppGJM
//
//  Created by Francisco Juan on 20/03/25.
//

import SwiftUI
import SwiftData

struct ListMedicinesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var medicines: [MedicineModel]
    @State var search: String = ""
    
    @State var addMedicine: Bool = false
    @State var editMedicine: Bool = false
    
    var body: some View {
        NavigationStack {
            if medicines.isEmpty {
                VStack {
                    Image("home.empty.placeholder")
                    Text("Você ainda não tem medicamentos adicionados")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.title)
                    
                    Text("Aperte no botão abaixo para adicionar algum medicamento")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("Title"))
                    
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
                        .background(Color.button)
                        .foregroundColor(.white)
                        .containerShape(.capsule)
                    }
                }
                .padding(16)
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
                                .tint(.button)
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(role: .destructive) {
                                    modelContext.delete(medicine)
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(.red)
                                Button {
                                    editMedicine.toggle()
                                } label: {
                                    Image(systemName: "pencil.and.scribble")
                                }
                                .tint(.blue)
                            }
                            .listRowSeparator(.hidden)
                            .listRowInsets(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                            .contextMenu {
                                Button {
                                    medicine.takeDose()
                                } label: {
                                    Label("Tomar medicamento",systemImage: "checkmark.arrow.trianglehead.counterclockwise")
                                }
                                Button {
                                    editMedicine.toggle()
                                } label: {
                                    Label("Editar",systemImage: "pencil.and.scribble")
                                }
                                Button(role: .destructive) {
                                    medicine.takeDose()
                                } label: {
                                    Label("Apagar",systemImage: "trash")
                                }
                            }
                            .sheet(isPresented: $editMedicine) {
                                EditMedicineView(medicine: medicine)
                            }
                    }
                    .listStyle(.plain)
                }
                .listStyle(.plain)
            }
            VStack {
                Text("")
            }
            .sheet(isPresented: $addMedicine) {
                AddMedicineView()
            }
            .navigationTitle("Medicamentos")
            .searchable(text: $search)
            .toolbar {
                ToolbarItem(
                    placement: .topBarTrailing
                ) {
                    Button {
                        addMedicine.toggle()
                    } label: {
                        Image(systemName:"plus.circle.fill")
                            .tint(.button)
                    }
                }
            }
        }
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = .background
            appearance.titleTextAttributes = [.foregroundColor: UIColor.title]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.title]
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            
        }
    }
}

#Preview {
    ListMedicinesView()
        .modelContainer(for: [MedicineModel.self], inMemory: true)
}
