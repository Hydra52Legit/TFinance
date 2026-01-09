//
//  TransactionViewModel.swift
//  TFinance
//
//  Created by Alex Kornilov on 5. 1. 2026..
//


// ViewModels/TransactionViewModel.swift
import SwiftUI
import Combine

@MainActor
class TransactionViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let dataService: MockDataService
    
    // Designated initializer without default argument
    init(dataService: MockDataService) {
        self.dataService = dataService
    }
    
    // Convenience initializer that supplies the default on the main actor
    convenience init() {
        self.init(dataService: MockDataService.shared)
    }
    
    // Загрузка транзакций
    func loadTransactions() {
        isLoading = true
        errorMessage = nil
        
        // Имитация сетевой задержки
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.transactions = self.dataService.generateTransactions()
            self.isLoading = false
        }
    }
    
    // Статистика по категориям
    var categoryStatistics: [Category: Double] {
        transactions
            .filter { $0.type == .expense }
            .reduce(into: [Category: Double]()) { result, transaction in
                result[transaction.category, default: 0] += transaction.amount
            }
    }
    
    // Общая сумма расходов
    var totalExpenses: Double {
        transactions
            .filter { $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
    }
    
    // Общая сумма доходов
    var totalIncome: Double {
        transactions
            .filter { $0.type == .income }
            .reduce(0) { $0 + $1.amount }
    }
    
    // Баланс
    var balance: Double {
        totalIncome - totalExpenses
    }
    
    // AI-инсайт (простой пример)
    var aiInsight: String {
        guard totalExpenses > 0 else { return "Начните отслеживать расходы!" }
        
        let topCategory = categoryStatistics.max { $0.value < $1.value }
        
        if let category = topCategory?.key, let amount = topCategory?.value {
            let percentage = Int((amount / totalExpenses) * 100)
            return "Больше всего вы тратите на \(category.rawValue.lowercased()) — \(percentage)% от всех расходов"
        }
        
        return "Анализируем ваши расходы..."
    }
}
