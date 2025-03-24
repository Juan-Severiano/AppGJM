//
//  MedicineView.swift
//  AppGJM
//
//  Created by Francisco Juan on 18/03/25.
//

import SwiftUI

struct MedicineView: View {
    let medicine: MedicineModel
    
    var body: some View {
        HStack {
            Image(medicine.format.rawValue)
            VStack(alignment: .leading) {
                HStack {
                    Text(medicine.name)
                        .font(.title2.bold())
                        .foregroundColor(.black)
                        .padding(.vertical, 2)
                    Spacer()
                    
                    Label {
                        Text(calculateNextMedicineHour(start: medicine.firstMedicineHour, step: medicine.repetition))
                            .dynamicTypeSize(.small)
                    } icon: {
                        Image(systemName: "alarm.waves.left.and.right")
                            .foregroundColor(.primary)
                    }.font(.footnote)
                }
                
                HStack(alignment: .bottom, spacing: 1) {
                    VStack(alignment: .leading, spacing: 1) {
                        Label {
                            Text(medicine.days.rawValue)
                        } icon: {
                            Image(systemName: "calendar")
                                .foregroundColor(.primary)
                        }
                        Label {
                            Text("\(medicine.format.rawValue) - \(medicine.quantity)\(medicine.typeOfMedicine.rawValue)")
                        } icon: {
                            Image(systemName: "pills")
                                .foregroundColor(.primary)
                        }
                        Label {
                            Text(medicine.repetition.rawValue)
                        } icon: {
                            Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                                .foregroundColor(.primary)
                        }
                    }
                    .font(.caption)
                    Spacer()
                    CustomProgressView(progress: CGFloat(medicine.dosesTaken) / CGFloat(medicine.totalDosesPerDay), label: medicine.getSteps())
                }
            }
            .padding(6)
            .background {
                Color.white
            }
        }
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.gray.opacity(0.5))
                .shadow(radius: 4.0, x: 1.0, y: 1.0)
        }
    }
    
    func calculateNextMedicineHour(start: Date, step: Repetition) -> String {
        let range: Int = getRepetitionNumber(repetition: step)
        let nextMedicineHour = Calendar.current.date(byAdding: .hour, value: range, to: start)!
        return nextMedicineHour.formatted(.dateTime.hour().minute())
    }
}

#Preview {
    MedicineView(
        medicine: MedicineModel(name: "Dipirona", quantity: 1, typeOfMedicine: TypeOfMedicine.g, format: .comprimido, alarm: true, firstTime: Date(), repetition: Repetition.every6Hours, firstMedicineHour: Date(), purpose: "Dor de Cabeça", days: .everyDay)
    )
}
