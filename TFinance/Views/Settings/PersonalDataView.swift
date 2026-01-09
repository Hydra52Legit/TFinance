//
//  PersonalDataView.swift
//  TFinance
//
//  Created by Alex Kornilov on 7. 1. 2026..
//

// Views/Settings/PersonalDataView.swift
import SwiftUI

struct PersonalDataView: View {
    @State private var name = "Александр"
    @State private var email = "alex@example.com"
    @State private var phone = "+7 (999) 123-45-67"
    @State private var showingSaveAlert = false
    
    var body: some View {
        Form {
            Section("Основная информация") {
                TextField("Имя", text: $name)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                TextField("Телефон", text: $phone)
                    .keyboardType(.phonePad)
            }
            
            Section("Дополнительно") {
                DatePicker("Дата рождения",
                          selection: .constant(Date()),
                          displayedComponents: .date)
                
                Picker("Пол", selection: .constant(0)) {
                    Text("Не указано").tag(0)
                    Text("Мужской").tag(1)
                    Text("Женский").tag(2)
                }
            }
            
            Section {
                Button {
                    saveChanges()
                } label: {
                    Text("Сохранить изменения")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .listRowBackground(Color.clear)
            }
        }
        .navigationTitle("Личные данные")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Изменения сохранены", isPresented: $showingSaveAlert) {
            Button("OK", role: .cancel) { }
        }
    }
    
    private func saveChanges() {
        // Сохранение в UserDefaults или API
        print("Сохранено: \(name), \(email), \(phone)")
        showingSaveAlert = true
    }
}
