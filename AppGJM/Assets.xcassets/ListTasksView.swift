//
//  ListTasksView.swift
//  AppGJM
//
//  Created by Geovana on 20/03/25.
//

import SwiftUI
import SwiftData

struct ListTasksView: View {
    @Query var tasks: [TaskModel]
    @State var search: String = ""
    
    @State var addTask: Bool = false
    
    var body: some View {
        NavigationStack {
            if tasks.isEmpty {
                VStack {
                    Image("tasks.empty.placeholder")
                    Text("Você ainda não tem tarefas adicionadas")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    
                    Text("Aperte no botão abaixo para adicionar uma tarefa")
                        .multilineTextAlignment(.center)
                    
                    HStack {
                        Button {
                            addTask.toggle()
                        } label: {
                            Label {
                                Text("Adicionar")
                            } icon: {
                                Image(systemName: "plus")
                            }
                            .frame(width: 150)
                        }
                        .padding(10)
                        .background(Color.black.opacity(0.7))
                        .foregroundColor(.white)
                        .containerShape(.capsule)
                    }
                }
                .padding(20)
            } else {
                Text("olha a lista ai")
            }
            VStack {
                Text("")
            }
            .sheet(isPresented: $addTask) {
                AddTaskView()
            }
            .navigationTitle("Tarefas")
            .searchable(text: $search)
            .toolbar {
                ToolbarItem(
                    placement: .topBarTrailing
                ) {
                    Button {
                        addTask.toggle()
                    } label: {
                        Image(systemName:"plus.circle")
                            .tint(.black.opacity(0.7))
                    }
                }
            }
        }
    }
}

#Preview {
    ListTasksView()
        .modelContainer(for: [TaskModel.self])
}
