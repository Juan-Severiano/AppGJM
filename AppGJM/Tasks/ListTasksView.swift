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
                List {
                    ForEach(tasks.filter { search.isEmpty || $0.name.localizedCaseInsensitiveContains(search) }) { task in
                        TaskView(task: task)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(role: .destructive) {
//                                    medicine.takeDose()
                                } label: {
                                    Image(systemName: "trash")
                                }
                                Button {
//                                    medicine.takeDose()
                                } label: {
                                    Image(systemName: "pencil.and.scribble")
                                }
                                .background(Color.blue)
                            }
                            .listRowSeparator(.hidden)
                            .listRowInsets(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                            .contextMenu {
                                Button {
//                                    medicine.takeDose()
                                } label: {
                                    Label("Editar",systemImage: "pencil.and.scribble")
                                }
                                Button(role: .destructive) {
//                                    medicine.takeDose()
                                } label: {
                                    Label("Apagar",systemImage: "trash")
                                }
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
                            .tint(.black.opacity(0.7))
                    }
                }
            }
        }
    }
}

#Preview {
    ListTasksView()
        .modelContainer(for: [TaskModel.self], inMemory: true) { result in
            do {
                let container = try result.get()
                for i in 1...9 {
                    let task = TaskModel(name: "Task \(i)", priority: Priority.important, hasAlarm: false, days: Days.tomorow, activity: Activity.cleaning, hour: Date(), isDone: false)
                    container.mainContext.insert(task)
                }
            } catch {
                print(error)
            }
        }
}
