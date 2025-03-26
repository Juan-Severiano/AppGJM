//
//  MedicineModel.swift
//  AppGJM
//
//  Created by Francisco Juan on 17/03/25.
//

import Foundation
import SwiftData

enum Repetition: String, CaseIterable, Codable {
    case every4Hours = "4 em 4 horas"
    case every6Hours = "6 em 6 horas"
    case every8Hours = "8 em 8 horas"
    case every12Hours = "12 em 12 horas"
}

enum TypeOfMedicine: String, CaseIterable, Codable {
    case mg = "mg"
    case g = "g"
    case ml = "ml"
    case mcg = "mcg"
}

enum Formats: String, CaseIterable, Codable {
    case comprimido = "Comprimido"
    case capsula = "Capsula"
    case gotas = "Gotas"
    case injecao = "Injeção"
    case other = "Outro"
}

enum Days: String, CaseIterable, Codable {
    case everyDay = "Todos os dias"
    case today = "Hoje"
    case tomorow = "Amanhã"
    case specificDays = "Dias específicos"
}

enum SpecificDays: String, CaseIterable, Codable {
    case sunday = "Dom"
    case monday = "Seg"
    case tuesday = "Ter"
    case wednesday = "Qua"
    case thursday = "Qui"
    case friday = "Sext"
    case sathurday = "Sáb"
}

@Model
class MedicineModel {
    var id: UUID
    var name: String
    var quantity: Int
    var typeOfMedicine: TypeOfMedicine
    var format: Formats
    var alarm: Bool
    var firstTime: Date
    var repetition: Repetition
    var firstMedicineHour: Date
    var purpose: String
    var days: Days
    var specificDays: Set<String> = []
    
    var dosesTaken: Int
    var totalDosesPerDay: Int
    
    init(name: String, quantity: Int, typeOfMedicine: TypeOfMedicine, format: Formats, alarm: Bool, firstTime: Date, repetition: Repetition, firstMedicineHour: Date, purpose: String, days: Days) {
        self.id = UUID()
        self.name = name
        self.quantity = quantity
        self.typeOfMedicine = typeOfMedicine
        self.format = .comprimido
        self.alarm = alarm
        self.firstTime = firstTime
        self.repetition = repetition
        self.firstMedicineHour = firstMedicineHour
        self.purpose = purpose
        self.dosesTaken = 0
        
        let dayTotalHours = 24
        let rangeOfRepetition = getRepetitionNumber(repetition: repetition)
        self.totalDosesPerDay = dayTotalHours / Int(rangeOfRepetition)
        self.days = days
        self.specificDays = []
    }
    
    func getSteps() -> String {
        return "\(dosesTaken)/\(totalDosesPerDay)"
    }
    
    func takeDose() {
        if dosesTaken < totalDosesPerDay {
            dosesTaken += 1
        }
    }
}
