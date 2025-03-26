//
//  TasksModel.swift
//  AppGJM
//
//  Created by Geovana on 17/03/25.
//

import Foundation
import SwiftData
import SwiftUI

func getColorByPriority(_ priority: Priority) -> Color {
    switch priority {
    case .urgent:
        return .red
    case .important:
        return .orange
    case .routine:
        return .green
    }
}

enum Priority: String, Codable, CaseIterable {
    case urgent = "Urgente"
    case important = "Importante"
    case routine = "Rotina"
}

enum Activity: String, Codable, CaseIterable {
    case cleaning = "Limpeza"
}

@Model
class TaskModel: Identifiable {
    var name: String
    var priority: Priority
    var hasAlarm: Bool
    var days: Days
    
    var specificDays: String?
    
    var activity: Activity
    
    var hour: Date
    
    var isDone: Bool
    
    init(name: String, priority: Priority, hasAlarm: Bool, days: Days, specificDays: String? = nil, activity: Activity, hour: Date, isDone: Bool) {
        self.name = name
        self.priority = priority
        self.hasAlarm = hasAlarm
        self.days = days
        self.specificDays = specificDays
        self.activity = activity
        self.hour = hour
        
        self.isDone = isDone
    }
}
