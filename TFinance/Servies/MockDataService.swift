// Services/MockDataService.swift
import Foundation

class MockDataService {
    static let shared = MockDataService()
    private init() {}
    
    // Генерация случайных транзакций
    func generateTransactions(count: Int = 50) -> [Transaction] {
        var transactions: [Transaction] = []
        let descriptions = [
            "Покупка в магазине", "Оплата такси", "Кафе", "Кино", "Аптека",
            "Заправка", "Онлайн-покупка", "Перевод", "Зарплата", "Кэшбэк",
            "Подписка Netflix", "Абонемент в спортзал", "Книги", "Курсы"
        ]
        
        let currentDate = Date()
        let calendar = Calendar.current
        
        for _ in 0..<count {
            // Случайная дата в пределах последних 30 дней
            let daysAgo = Int.random(in: 0...30)
            let date = calendar.date(byAdding: .day, value: -daysAgo, to: currentDate)!
            
            // Случайная сумма (70% расходов, 30% доходов)
            let isExpense = Double.random(in: 0...1) < 0.7
            let type: TransactionType = isExpense ? .expense : .income
            let amount = isExpense ?
                Double.random(in: 100...5000) : // Расходы
                Double.random(in: 1000...50000) // Доходы
            
            // Случайная категория
            let category = Category.allCases.randomElement() ?? .other
            
            // Случайное описание
            let description = descriptions.randomElement() ?? "Транзакция"
            
            let transaction = Transaction(
                date: date,
                amount: amount,
                category: category,
                description: description,
                type: type
            )
            
            transactions.append(transaction)
        }
        
        // Сортируем по дате (сначала новые)
        return transactions.sorted { $0.date > $1.date }
    }
    
    // Статистика за месяц
    func getMonthlyStatistics() -> [Category: Double] {
        let transactions = generateTransactions()
        var statistics: [Category: Double] = [:]
        
        for category in Category.allCases {
            let total = transactions
                .filter { $0.category == category && $0.type == .expense }
                .reduce(0) { $0 + $1.amount }
            statistics[category] = total
        }
        
        return statistics
    }
}
