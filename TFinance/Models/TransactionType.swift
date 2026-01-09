// Models/Transaction.swift
import Foundation

enum TransactionType: String, Codable, CaseIterable {
    case expense = "Расход"
    case income = "Доход"
}

enum Category: String, Codable, CaseIterable {
    case food = "Еда"
    case transport = "Транспорт"
    case entertainment = "Развлечения"
    case shopping = "Шоппинг"
    case healthcare = "Здоровье"
    case education = "Образование"
    case other = "Другое"
    
    var icon: String {
        switch self {
        case .food: return "🍕"
        case .transport: return "🚗"
        case .entertainment: return "🎬"
        case .shopping: return "🛍️"
        case .healthcare: return "🏥"
        case .education: return "📚"
        case .other: return "📦"
        }
    }
    
    var color: String {
        switch self {
        case .food: return "#FF6B6B"
        case .transport: return "#4ECDC4"
        case .entertainment: return "#FFD166"
        case .shopping: return "#06D6A0"
        case .healthcare: return "#118AB2"
        case .education: return "#073B4C"
        case .other: return "#6A5ACD"
        }
    }
}

struct Transaction: Identifiable, Codable, Equatable {
    let id: UUID
    let date: Date
    let amount: Double
    let currency: String
    let category: Category
    let description: String
    let type: TransactionType
    
    init(
        id: UUID = UUID(),
        date: Date = Date(),
        amount: Double,
        currency: String = "RUB",
        category: Category,
        description: String,
        type: TransactionType
    ) {
        self.id = id
        self.date = date
        self.amount = amount
        self.currency = currency
        self.category = category
        self.description = description
        self.type = type
    }
}

