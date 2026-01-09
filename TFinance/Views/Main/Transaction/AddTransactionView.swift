// Views/AddTransactionView.swift
import SwiftUI

struct AddTransactionView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var amountText: String = ""
    @State private var descriptionText: String = ""
    @State private var selectedType: TransactionType = .expense
    @State private var selectedCategory: Category = .other
    @State private var date: Date = Date()
    
    let onAdd: (Transaction) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Сумма")) {
                    TextField("0", text: $amountText)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Описание")) {
                    TextField("Например, Кофе", text: $descriptionText)
                }
                
                Section(header: Text("Тип")) {
                    Picker("Тип", selection: $selectedType) {
                        ForEach(TransactionType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("Категория")) {
                    Picker("Категория", selection: $selectedCategory) {
                        ForEach(Category.allCases, id: \.self) { category in
                            Text("\(category.icon) \(category.rawValue)").tag(category)
                        }
                    }
                }
                
                Section(header: Text("Дата")) {
                    DatePicker("Дата", selection: $date, displayedComponents: .date)
                }
            }
            .navigationTitle("Новая операция")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        guard let amount = Double(amountText.replacingOccurrences(of: ",", with: ".")),
                              amount > 0 else {
                            // В реальном приложении можно показать алерт
                            return
                        }
                        let transaction = Transaction(
                            date: date,
                            amount: amount,
                            category: selectedCategory,
                            description: descriptionText.isEmpty ? selectedCategory.rawValue : descriptionText,
                            type: selectedType
                        )
                        onAdd(transaction)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddTransactionView { _ in }
}
