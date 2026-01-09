// Views/Settings/SettingsItemView.swift
import SwiftUI

struct SettingsItemView: View {
    let item: SettingsItemType
    @ObservedObject var viewModel: SettingsViewModel
    
    @State private var toggleState: Bool = false
    @State private var showingActionSheet = false
    
    var body: some View {
        Group {
            switch item {
            case .navigation(let title, let icon, let color):
                NavigationLink {
                    destinationView(for: title)
                } label: {
                    SettingsRow(icon: icon, color: color, title: title)
                }
                
            case .toggle(let title, let icon, let color, let isOn):
                Toggle(isOn: $toggleState) {
                    SettingsRow(icon: icon, color: color, title: title, showsChevron: false)
                }
                .onAppear { toggleState = isOn }
                .onChange(of: toggleState) {
                    handleToggleChange(title: title, isOn: toggleState, )
                }
                .tint(color)
                
            case .button(let title, let icon, let color, let role):
                Button {
                    handleButtonAction(title: title)
                } label: {
                    SettingsRow(icon: icon, color: color, title: title, showsChevron: false)
                        .foregroundColor(role == .destructive ? .red : .primary)
                }
                
            case .info(let title, let value, let icon, let color):
                HStack {
                    SettingsRow(icon: icon, color: color, title: title,showsChevron: false)
                    Spacer()
                    Text(value)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
    // MARK: - Обработчики действий
    
    private func handleToggleChange(title: String, isOn: Bool) {
        switch title {
        case let str where str.contains("Face ID") ||
                           str.contains("Touch ID") ||
                           str.contains("Биометрия"):
            viewModel.toggleBiometric(isOn)
        case "Скрыть суммы":
            UserDefaults.standard.set(isOn, forKey: "hideAmounts")
            NotificationCenter.default.post(
                name: NSNotification.Name("HideAmountsChanged"),
                object: isOn
            )
        case "Push-уведомления":
            print("Уведомления: \(isOn ? "включены" : "выключены")")
        default:
            break
        }
    }
    
    private func handleButtonAction(title: String) {
        switch title {
        case "Очистить кэш":
            showingActionSheet = true
        case "Поделиться приложением":
            shareApp()
        default:
            break
        }
    }
    
    private func shareApp() {
        guard let url = URL(string: "https://apps.apple.com/app/id123456789") else { return }
        let activityVC = UIActivityViewController(
            activityItems: [url],
            applicationActivities: nil
        )
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }
    
    // MARK: - Навигация
    
    @ViewBuilder
    private func destinationView(for title: String) -> some View {
        // Все пункты ведут на заглушку, чтобы не было ошибок компиляции
        PlaceholderView(title: title)
    }
}

// Временный заглушечный View
struct PlaceholderView: View {
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .padding()
            
            Text("Этот экран находится в разработке")
                .foregroundColor(.gray)
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Preview
#Preview {
    let viewModel = SettingsViewModel()
    
    return List {
        SettingsItemView(
            item: .navigation(title: "Личные данные", icon: "person.fill", color: .blue),
            viewModel: viewModel
        )
        
        SettingsItemView(
            item: .toggle(title: "Face ID", icon: "faceid", color: .purple, isOn: true),
            viewModel: viewModel
        )
        
        SettingsItemView(
            item: .info(title: "Версия", value: "1.0.0", icon: "number", color: .gray),
            viewModel: viewModel
        )
    }
}
