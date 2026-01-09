// Views/Main/TransactionListView.swift
import SwiftUI

struct TransactionListView: View {
    @StateObject private var viewModel = TransactionViewModel()
    @State private var showingAddTransaction = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Основной контент
                List {
                    // Баннер с балансом
                    balanceSection
                    
                    // Секция с AI-инсайтом
                    insightSection
                    
                    // Список транзакций
                    transactionsSection
                }
                .listStyle(.insetGrouped)
                .navigationTitle("T-Финансы")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { viewModel.loadTransactions() }) {
                            Image(systemName: "arrow.clockwise")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { showingAddTransaction = true }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                
                // Индикатор загрузки
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.1))
                }
            }
        }
        .onAppear {
            if viewModel.transactions.isEmpty {
                viewModel.loadTransactions()
            }
        }
        .sheet(isPresented: $showingAddTransaction) {
            AddTransactionView { newTransaction in
                // Добавляем новую транзакцию в начало списка
                viewModel.transactions.insert(newTransaction, at: 0)
            }
        }
    }
    
    // Баннер с балансом
    private var balanceSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 12) {
                Text("Ваш баланс")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("\(viewModel.balance, specifier: "%.2f") ₽")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(viewModel.balance >= 0 ? .green : .red)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Доходы")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("+\(viewModel.totalIncome, specifier: "%.0f") ₽")
                            .font(.headline)
                            .foregroundColor(.green)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("Расходы")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("-\(viewModel.totalExpenses, specifier: "%.0f") ₽")
                            .font(.headline)
                            .foregroundColor(.red)
                    }
                }
            }
            .padding(.vertical, 8)
        }
    }
    
    // AI-инсайт
    private var insightSection: some View {
        Section {
            HStack {
                Image(systemName: "brain.head.profile")
                    .foregroundColor(.blue)
                    .font(.title2)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("AI-инсайт")
                        .font(.caption)
                        .foregroundColor(.blue)
                    Text(viewModel.aiInsight)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                .padding(.leading, 8)
            }
            .padding(.vertical, 8)
        }
    }
    
    // Список транзакций
    private var transactionsSection: some View {
        Section(header: Text("Последние операции")) {
            if viewModel.transactions.isEmpty && !viewModel.isLoading {
                VStack(spacing: 16) {
                    Image(systemName: "creditcard")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    Text("Нет операций")
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
            } else {
                ForEach(viewModel.transactions.prefix(20)) { transaction in
                    TransactionRowView(transaction: transaction)
                }
            }
        }
    }
}

// Ячейка транзакции
struct TransactionRowView: View {
    let transaction: Transaction
    
    var body: some View {
        HStack(spacing: 12) {
            // Иконка категории
            Circle()
                .fill(Color(hex: transaction.category.color))
                .frame(width: 40, height: 40)
                .overlay(
                    Text(transaction.category.icon)
                        .font(.system(size: 20))
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.description)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(transaction.category.rawValue)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(transaction.date.formatted(date: .medium, time: .none))
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text("\(transaction.type == .expense ? "-" : "+")\(transaction.amount, specifier: "%.0f") ₽")
                .font(.headline)
                .foregroundColor(transaction.type == .expense ? .red : .green)
        }
        .padding(.vertical, 4)
    }
}



// Предварительный просмотр
#Preview {
    TransactionListView()
}
