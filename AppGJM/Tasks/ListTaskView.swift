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

    @State var selectedPriority: TaskModel.TaskPriority? = nil
    @State var showaddtask = false
    @State var searchText = ""
    @State var showAddTask: Bool = false
    
    var filteredTask: [TaskModel] {
        guard let selectedPriority = selectedPriority else { return task}
        return task.filter{ $0.priority == selectedPriority }
    }
    var body: some View {
        NavigationStack {
            VStack {
                Text("Todas").tag(nil as TaskModel.TaskPriority?)
                ForEach(TaskModel.TaskPriority.allCases, id: \.self) { priority in
                    Text(priority.rawValue).tag(priority as TaskModel.TaskPriority?)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if filteredTask.isEmpty {
                VStack {
                    Image(systemName: "line.3.horizontal.decrease")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.black)
                }
                .padding()
            } else {
                List {
                    ForEach(task) { taskItem in
                        HStack {
                            Text(taskItem.tittle)
                            Spacer()
                            Text(taskItem.priority.rawValue)
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                modelContext.delete(taskItem)
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                    
//                    .onDelete(perform: deleteTask)
                }
            }
            Spacer()
            
            Button(action: {
                showAddTask.toggle()
            }) {
                HStack {
                    Image(systemName: "plus")
                    Text("Adicionar")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .cornerRadius(8)
                .padding()
            }
            .sheet(isPresented: $showAddTask) {
                AddTaskView()
            }
        }
        .navigationTitle("Tarefas")
    }
            
}




    #Preview {
        ListTaskView()
    }
