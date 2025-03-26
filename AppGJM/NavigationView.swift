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
            Tab("Medicamentos", systemImage: "pills") {
                ListMedicinesView()
            }
            Tab("Tarefas", systemImage: "list.bullet.clipboard.fill") {
                ListTasksView()
            }
            Tab("Resumo", systemImage: "folder.fill.badge.person.crop") {
                ResumoView()
            }
        }
        .tint(Color.button)
    }
}

#Preview {
    NavigationView()
}
