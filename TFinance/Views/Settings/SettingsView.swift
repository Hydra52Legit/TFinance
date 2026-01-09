//
//  SettingView.swift
//  TFinance
//
//  Created by Alex Kornilov on 7. 1. 2026..
//

// Views/Settings/SettingsView.swift
import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State private var showingLogoutAlert = false
    @State private var showingClearCacheAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Основной контент
                List {
                    // Header
                    headerSection
                    
                    // Секции настроек
                    ForEach(viewModel.settings) { section in
                        Section(section.title) {
                            ForEach(Array(section.items.enumerated()), id: \.offset) { _, item in
                                SettingsItemView(item: item, viewModel: viewModel)
                            }
                        }
                    }
                    
                    // Выход
                    logoutSection
                }
                .listStyle(.insetGrouped)
                .navigationBarHidden(true)
                
                // Индикатор загрузки
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                }
            }
            .alert("Выйти из аккаунта?", isPresented: $showingLogoutAlert) {
                Button("Отмена", role: .cancel) { }
                Button("Выйти", role: .destructive) {
                    viewModel.logout()
                }
            } message: {
                Text("Вы уверены, что хотите выйти? После выхода потребуется войти снова.")
            }
            .alert("Очистить кэш?", isPresented: $showingClearCacheAlert) {
                Button("Отмена", role: .cancel) { }
                Button("Очистить", role: .destructive) {
                    clearCache()
                }
            } message: {
                Text("Это действие удалит все временные данные приложения.")
            }
        }
    }
    
    // MARK: - Компоненты
    
    private var headerSection: some View {
        VStack(spacing: 16) {
            Image(systemName: "gear.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
                .padding(.top, 20)
            
            Text("Настройки")
                .font(.largeTitle.bold())
                .foregroundColor(.primary)
            
            Text("Настройте приложение под себя")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets())
    }
    
    private var logoutSection: some View {
        Section {
            Button(role: .destructive) {
                showingLogoutAlert = true
            } label: {
                HStack {
                    Spacer()
                    Label("Выйти из аккаунта", systemImage: "rectangle.portrait.and.arrow.right")
                    Spacer()
                }
            }
        }
    }
    
    // MARK: - Действия
    
    private func clearCache() {
        // Очистка кэша
        URLCache.shared.removeAllCachedResponses()
        
        // Очистка UserDefaults (кроме важных настроек)
        let defaults = UserDefaults.standard
        let biometricEnabled = defaults.bool(forKey: "biometricEnabled")
        let hideAmounts = defaults.bool(forKey: "hideAmounts")
        
        defaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        
        // Восстанавливаем важные настройки
        defaults.set(biometricEnabled, forKey: "biometricEnabled")
        defaults.set(hideAmounts, forKey: "hideAmounts")
        defaults.synchronize()
        
        print("Кэш очищен")
    }
}

// MARK: - Preview
#Preview {
    SettingsView()
        .preferredColorScheme(.dark) // Проверяем в темной теме
}

#Preview("Light Mode") {
    SettingsView()
        .preferredColorScheme(.light)
}
