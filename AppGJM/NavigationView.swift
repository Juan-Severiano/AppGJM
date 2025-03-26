//
//  NavigationView.swift
//  AppGJM
//
//  Created by Francisco Juan on 24/03/25.
//

import SwiftUI

struct NavigationView: View {
    var body: some View {
        TabView {
            Tab("Medicines", systemImage: "pills") {
                ListMedicinesView()
            }
            Tab("Tasks", systemImage: "list.bullet.clipboard.fill") {
                ListTasksView()
            }
            Tab("Resumo", systemImage: "folder.fill.badge.person.crop") {
                ListMedicinesView()
            }
        }
        .tint(Color.button)
    }
}

#Preview {
    NavigationView()
        .modelContainer(for: [TaskModel.self,MedicineModel.self], inMemory: true) { result in
            do {
                let container = try result.get()
                for i in 1...9 {
                    let medicine = MedicineModel(name: "Medicamento \(i)", quantity: i, typeOfMedicine: TypeOfMedicine.mg, format: .capsula, alarm: i % 2 == 0, firstTime: Date(), repetition: Repetition.every6Hours, firstMedicineHour: Date(), purpose: "Dor e febre", days: .everyDay)
                    container.mainContext.insert(medicine)
                }
            } catch {
                print(error)
            }
        }
}
