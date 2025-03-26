//
//  Utils.swift
//  AppGJM
//
//  Created by Francisco Juan on 18/03/25.
//

import SwiftUI

func getRepetitionNumber(repetition: Repetition) -> Int {
    switch repetition {
    case .every12Hours:
        return 12
    case .every4Hours:
        return 4
    case .every6Hours:
        return 6
    case .every8Hours:
        return 8
    }
}
//
//func sendAlarm() {
//    var dateComponents = DateComponents()
//    dateComponents.calendar = Calendar.current
//
//
//    dateComponents.weekday = 4  // Tuesday
//    dateComponents.hour = 15    // 14:00 hours
//    dateComponents.minute = 28
//       
//    let trigger = UNCalendarNotificationTrigger(
//             dateMatching: dateComponents, repeats: true)
//}
