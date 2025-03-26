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
    @State var editTask: Bool = false
    
    var body: some View {
        NavigationStack {
            if tasks.isEmpty {
                VStack {
                    Image("tasks.empty.placeholder")
                    Text("Você ainda não tem tarefas adicionadas")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("Title"))
                    
                    Text("Aperte no botão abaixo para adicionar uma tarefa")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("Title"))
                    
                    HStack {
                        Button {
                            addTask.toggle()
                        } label: {
                            Label {
                                Text("Adicionar")
                                    .font(.headline)
                            } icon: {
                                Image(systemName: "plus")
                                    .font(.headline)
                            }
                            .frame(width: 150)
                        }
                        .padding(10)
                        .background(Color.button)
                        .foregroundColor(.white)
                        .containerShape(.capsule)
                    }
                }
                .padding(20)
            } else {
                List {
                    ForEach(tasks.filter { search.isEmpty || $0.name.localizedCaseInsensitiveContains(search) }) { task in
                        TaskView(task: task)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(role: .destructive) {
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(.red)
                                Button {
                                    editTask.toggle()
                                } label: {
                                    Image(systemName: "pencil.and.scribble")
                                }
                                .tint(.blue)
                            }
                            .listRowSeparator(.hidden)
                            .listRowInsets(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                            .contextMenu {
                                Button {
                                    editTask.toggle()
                                } label: {
                                    Label("Editar",systemImage: "pencil.and.scribble")
                                }
                            
                                Button(role: .destructive) {
                                } label: {
                                    Label("Apagar",systemImage: "trash")
                                }
                            }
                            .sheet(isPresented: $editTask) {
                                EditTaskView(task: task)
                            }
                    }
                    .listStyle(.plain)
                }
                .listStyle(.plain)

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
                        Image(systemName:"plus.circle.fill")
                        .tint(.button)                    }
                }
            }
        }
    }
}

#Preview {
    ListTasksView()
        .modelContainer(for: [TaskModel.self], inMemory: true)

}
