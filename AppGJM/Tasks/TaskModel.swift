//
//  TasksModel.swift
//  AppGJM
//
//  Created by user on 17/03/25.
//

import Foundation
import SwiftData
import Observation

@Model
class TaskModel: Identifiable {
    var id = UUID()
    var tittle: String
    var date: Date
    var isDone: Bool
    var priority: TaskPriority
    
    
    init(id: UUID, tittle: String, date: Date, isDone: Bool = false, priority: TaskPriority) {
        self.id = id
        self.tittle = tittle
        self.date = date
        self.isDone = isDone
        self.priority = priority
    }
    
    enum TaskPriority: String, CaseIterable, Codable {
        case urgente = "Urgente"
        case importante = "Importante"
        case rotina = "Rotina"
        
        var id: String { self.rawValue}
    }
    
}
