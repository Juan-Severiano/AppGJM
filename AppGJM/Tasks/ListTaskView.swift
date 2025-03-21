//
//  ListTaskView.swift
//  AppGJM
//
//  Created by user on 20/03/25.
//

import SwiftUI
import SwiftData

struct ListTaskView: View {
    @Environment(\.modelContext) var modelContext
    @Query var task: [TaskModel]
    
    @State var showaddtask = false
    @State var searchText = ""
    @State var addTask: Bool = false
        
    var body: some View {
        NavigationStack {
            EmptyView()
            
            
            ZStack {
                VStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .center, spacing: 10) {
                        
                    }
                  
                    .padding(0)
                    .frame(width: 324, height: 285.31616, alignment: .center)
                    .background(Color(red: 0.84, green: 0.84, blue: 0.84))
                    .cornerRadius(30)
                    
                    VStack(alignment: .center, spacing: 5) {
                        Text("Ainda não há tarefas adicionadas.")
                            .font (
                                Font.custom("SF Pro Display", size: 25))
                            .bold()
                          .multilineTextAlignment(.center)
                          .foregroundColor(Color(red: 0.12, green: 0.16, blue: 0.18))
                          .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 0)
                    .padding(.bottom, 16)
                    .frame(maxWidth: .infinity, minHeight: 131.76816, maxHeight: 131.76816, alignment: .center)
                }
                .padding(0)
                .frame(width: 361, alignment: .top)
            }
                .frame(width: 430, height: 932)
                .background(.white)
                .navigationTitle("Tarefas")
                .searchable(text: $searchText)
                .listStyle(.insetGrouped)
                           .sheet(isPresented: $addTask) {
                               AddTaskView()
                           }
                    }
                }
        }




#Preview {
    ListTaskView()
}
