//
//  MedicineModel.swift
//  AppGJM
//
//  Created by Francisco Juan on 17/03/25.
//

import Foundation

enum Repetition: String, CaseIterable {
    case every4Hours = "4 em 4 horas"
    case every6Hours = "6 em 6 horas"
    case every8Hours = "8 em 8 horas"
    case every12Hours = "12 em 12 horas"
}

class MedicineModel {
    let name: String
    let quantity: Int
    let typeOfMedicine: String
    let format: String
    var alarm: Bool
    let firtTime: Date
    let repetition: Repetition
    let firstMedicineHour: Date
    
    init(name: String, quantity: Int, typeOfMedicine: String, format: String, alarm: Bool, firtTime: Date, repetition: Repetition, firstMedicineHour: Date) {
        self.name = name
        self.quantity = quantity
        self.typeOfMedicine = typeOfMedicine
        self.format = format
        self.alarm = alarm
        self.firtTime = firtTime
        self.repetition = repetition
        self.firstMedicineHour = firstMedicineHour
    }
}
