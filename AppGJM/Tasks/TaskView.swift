//
//  MedicineView.swift
//  AppGJM
//
//  Created by Geovana on 18/03/25.
//

import SwiftUI

struct TaskView: View {
    let task: TaskModel
    
    var body: some View {
        HStack {
            Button {
                task.isDone.toggle()
            } label: {
                Image(systemName: task.isDone ? "checkmark.circle" :"circle")
                    .font(.system(size: 25))
                    .padding(.horizontal)
            }

            VStack(alignment: .leading) {
                HStack {
                    Text(task.name)
                        .font(.title2.bold())
                        .foregroundColor(.black)
                        .padding(.vertical, 2)
                        .strikethrough(task.isDone)
                    Spacer()

                    Text(task.priority.rawValue)
                        .font(.caption)
                        .padding(.vertical, 5)
                        .padding(.horizontal)
                        .background {
                            Capsule()
                                .fill(getColorByPriority(task.priority))
                        }
                        .foregroundColor(.white)
                        .padding(.trailing, 5)
                }
                
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 1) {
                        Label {
                            Text("\(task.days.rawValue) às \(task.hour.formatted(.dateTime.hour().minute()))")
                        } icon: {
                            Image(systemName: "calendar")
                                .foregroundColor(.primary)
                        }
                        Label {
                            Text(task.activity.rawValue)
                        } icon: {
                            Image(systemName: "flag.fill")
                                .foregroundColor(.primary)
                        }
                    }
                    .font(.caption)
                }
            }
            .padding(.vertical, 5)
        }
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.white)
                .shadow(radius: 4.0, x: 1.0, y: 1.0)
        }
    }
    
    
}

#Preview {
    TaskView(task: TaskModel(name: "Teste", priority: .routine, hasAlarm: true, days: .today, activity: .cleaning, hour: Date(), isDone: false))
}
