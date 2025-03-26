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
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 50)
            VStack(alignment: .leading) {
                    Text(medicine.name)
                        .font(.title3.bold())
                        .foregroundColor(.button)
                        .padding(.vertical, 2)
                
                HStack(alignment: .bottom, spacing: 1) {
                    VStack(alignment: .leading, spacing: 1) {
                        HStack(spacing: 8) {
                            Image(systemName: "calendar")
                            Text("\(medicine.days.rawValue) às \(medicine.firstMedicineHour.formatted(.dateTime.hour().minute()))")
                        }
                        HStack(spacing: 8) {
                            Image(systemName: "pills")
                            Text("\(medicine.format.rawValue) - \(medicine.quantity)\(medicine.typeOfMedicine.rawValue)")
                        }
                        HStack(spacing: 8) {
                            Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                            Text(medicine.repetition.rawValue)
                        }
                    }
                    .foregroundColor(.button)
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
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.accent)
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
