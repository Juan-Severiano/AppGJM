//
//  MedicineModel.swift
//  AppGJM
//
//  Created by Francisco Juan on 17/03/25.
//

import Foundation
import SwiftData

enum Repetition: String, CaseIterable {
    case every4Hours = "4 em 4 horas"
    case every6Hours = "6 em 6 horas"
    case every8Hours = "8 em 8 horas"
    case every12Hours = "12 em 12 horas"
}

enum TypeOfMedicine {
    case mg
    case g
    case ml
    case ampola
    case comprimido
}

@Model
class MedicineModel {
    var id: UUID
    var name: String
    var quantity: Int
    var typeOfMedicine: TypeOfMedicine
    var format: String
    var alarm: Bool
    var firstTime: Date
    var repetition: Repetition
    var firstMedicineHour: Date
    var purpose: String
    
    var steps: Float
    
    init(name: String, quantity: Int, typeOfMedicine: TypeOfMedicine, format: String, alarm: Bool, firstTime: Date, repetition: Repetition, firstMedicineHour: Date, purpose: String) {
        self.id = UUID()
        self.name = name
        self.quantity = quantity
        self.typeOfMedicine = typeOfMedicine
        self.format = format
        self.alarm = alarm
        self.firstTime = firstTime
        self.repetition = repetition
        self.firstMedicineHour = firstMedicineHour
        self.purpose = purpose
        self.steps = {
            let dayTotalHours = 24
            var labelOfRepetition = getRepetitionNumber(repetition: repetition)
            
            
            
            return Float(number / 10)
        }
    }
}
