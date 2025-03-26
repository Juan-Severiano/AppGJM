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
        }
        .tint(Color.button)
    }
}

#Preview {
    NavigationView()
}
