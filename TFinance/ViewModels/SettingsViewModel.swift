// ViewModels/SettingsViewModel.swift
import SwiftUI
import LocalAuthentication
import Combine

class SettingsViewModel: ObservableObject {
    @Published var settings: [SettingsSection] = []
    @Published var isLoading = false
    @Published var biometricType: LABiometryType = .none
    @Published var appVersion = "1.0.0"
    @Published var buildNumber = "123"
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadAppInfo()
        loadSettings()
        checkBiometricSupport()
    }
    
    private func loadAppInfo() {
        // Получаем версию из Info.plist
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            appVersion = version
        }
        if let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            buildNumber = build
        }
    }
    
    func loadSettings() {
        isLoading = true
        
        // Имитируем загрузку (в реальном приложении тут может быть API)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.settings = [
                SettingsSection(
                    title: "Профиль",
                    items: [
                        .navigation(title: "Личные данные", icon: "person.fill", color: .blue),
                        .navigation(title: "Безопасность", icon: "lock.fill", color: .red),
                        .navigation(title: "Платежные данные", icon: "creditcard.fill", color: .green)
                    ]
                ),
                SettingsSection(
                    title: "Конфиденциальность",
                    items: [
                        .toggle(
                            title: self.biometricTitle,
                            icon: self.biometricIcon,
                            color: .purple,
                            isOn: UserDefaults.standard.bool(forKey: "biometricEnabled")
                        ),
                        .toggle(
                            title: "Скрыть суммы",
                            icon: "eye.slash.fill",
                            color: .orange,
                            isOn: UserDefaults.standard.bool(forKey: "hideAmounts")
                        )
                    ]
                ),
                SettingsSection(
                    title: "Уведомления",
                    items: [
                        .toggle(title: "Push-уведомления", icon: "bell.fill", color: .blue, isOn: true),
                        .navigation(title: "Настройка уведомлений", icon: "bell.badge.fill", color: .red)
                    ]
                ),
                SettingsSection(
                    title: "О приложении",
                    items: [
                        .info(title: "Версия", value: self.appVersion, icon: "number", color: .gray),
                        .info(title: "Сборка", value: self.buildNumber, icon: "hammer.fill", color: .gray),
                        .button(title: "Очистить кэш", icon: "trash.fill", color: .gray),
                        .button(title: "Поделиться приложением", icon: "square.and.arrow.up", color: .blue)
                    ]
                )
            ]
            self.isLoading = false
        }
    }
    
    private var biometricTitle: String {
        switch biometricType {
        case .faceID: return "Face ID"
        case .touchID: return "Touch ID"
        default: return "Биометрия"
        }
    }
    
    private var biometricIcon: String {
        switch biometricType {
        case .faceID: return "faceid"
        case .touchID: return "touchid"
        default: return "lock"
        }
    }
    
    private func checkBiometricSupport() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                biometricType = context.biometryType
            }
        }
    
    func toggleBiometric(_ isEnabled: Bool) {
            if isEnabled {
                authenticateWithBiometrics { success in
                    DispatchQueue.main.async {
                        if success {
                            UserDefaults.standard.set(true, forKey: "biometricEnabled")
                        } else {
                            // Если аутентификация не удалась, возвращаем toggle в false
                            self.loadSettings()
                        }
                    }
                }
            } else {
                UserDefaults.standard.set(false, forKey: "biometricEnabled")
            }
        }
    
    private func authenticateWithBiometrics(completion: @escaping (Bool) -> Void) {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Для включения биометрии требуется аутентификация"
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                    completion(success)
                }
            } else {
                completion(false)
            }
        }
    
    func logout() {
        // Здесь будет реальная логика выхода
        // 1. Удалить токены из Keychain
        // 2. Очистить UserDefaults
        // 3. Отправить уведомление о выходе
        print("Пользователь вышел")
    }
}
