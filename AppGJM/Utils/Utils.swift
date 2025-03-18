//
//  Utils.swift
//  AppGJM
//
//  Created by Francisco Juan on 18/03/25.
//

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
