//
//  AppGJMApp.swift
//  AppGJM
//
//  Created by user on 17/03/25.
//

import SwiftUI
import SwiftData

@main
struct AppGJMApp: App {
    var body: some Scene {
        
        WindowGroup {
            NavigationView()
        }
        .modelContainer(for: [MedicineModel.self])
    }
}
