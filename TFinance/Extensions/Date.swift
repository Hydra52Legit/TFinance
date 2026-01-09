//
//  Date.swift
//  TFinance
//
//  Created by Alex Kornilov on 6. 1. 2026..
//

import SwiftUI

// Расширение для удобной работы с датами
extension Date {
    func formatted(date: DateFormatter.Style = .short, time: DateFormatter.Style = .none) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateStyle = date
        formatter.timeStyle = time
        return formatter.string(from: self)
    }
}
