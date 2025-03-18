//
//  AppGJMApp.swift
//  AppGJM
//
//  Created by user on 17/03/25.
//

import SwiftUI

@main
struct AppGJMApp: App {
    var body: some Scene {
        WindowGroup {
            MedicineView(medicine: MedicineModel(name: "Dipirona", quantity: 1, typeOfMedicine: TypeOfMedicine.g, format: "Comprimido", alarm: true, firstTime: Date(), repetition: Repetition.every6Hours, firstMedicineHour: Date(), purpose: "Dor de Cabeça"))
        }
    }
}
