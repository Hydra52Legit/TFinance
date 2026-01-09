//
//  SettingsModels.swift
//  TFinance
//
//  Created by Alex Kornilov on 7. 1. 2026..
//

import SwiftUI

enum SettingsItemType {
    case navigation(title: String, icon: String, color: Color)
    case toggle(title: String, icon: String, color: Color, isOn: Bool)
    case button(title: String, icon: String, color: Color, role: ButtonRole? = nil)
    case info(title: String, value: String, icon: String, color: Color)
}

struct SettingsSection: Identifiable {
    let id = UUID()
    let title: String
    let items: [SettingsItemType]
}
