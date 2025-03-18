//
//  MedicineView.swift
//  AppGJM
//
//  Created by Francisco Juan on 18/03/25.
//

import SwiftUI

struct MedicineView: View {
    let medicine: MedicineModel
    @State private var progress: CGFloat = 0.73

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("\(medicine.quantity)\(medicine.typeOfMedicine)")
                    .font(.callout)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background {
                        Capsule()
                            .fill(.white.opacity(0.3))
                    }
                
                Spacer()
                
                Label {
                    Text(calculateNextMedicineHour(start: medicine.firstMedicineHour, step: medicine.repetition))
                } icon: {
                    Image(systemName: "alarm.waves.left.and.right")
                }
            }
            
            Text(medicine.name)
                .font(.title2.bold())
                .foregroundColor(.black)
                .padding(.vertical, 6)
            
            HStack(alignment: .bottom, spacing: 5) {
                VStack(alignment: .leading, spacing: 5) {
                    Label {
                        Text((medicine.firstTime).formatted(date: .omitted, time: .shortened))
                    } icon: {
                        Image(systemName: "clock")
                    }
                    .font(.body)
                }
                Spacer()
                CustomProgressView(progress: $progress)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.pink.opacity(0.8))
        }
    }
    
    func calculateNextMedicineHour(start: Date, step: Repetition) -> String {
        var range: Int = getRepetitionNumber(repetition: step)
        let nextMedicineHour = Calendar.current.date(byAdding: .hour, value: range, to: start)!
        return nextMedicineHour.formatted(.dateTime.hour().minute())
    }
}

#Preview {
    MedicineView(
        medicine: MedicineModel(name: "Dipirona", quantity: 1, typeOfMedicine: TypeOfMedicine.g, format: "Comprimido", alarm: true, firstTime: Date(), repetition: Repetition.every6Hours, firstMedicineHour: Date(), purpose: "Dor de Cabeça")
    )
}
