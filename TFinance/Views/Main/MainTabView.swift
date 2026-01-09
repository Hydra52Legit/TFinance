//
//  MainTabView.swift
//  TFinance
//
//  Created by Alex Kornilov on 5. 1. 2026..
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab){
            TransactionListView()
                .tabItem{
                    Label("Операции", systemImage:"list.bullet")
                }
                .tag(0)
            StaticView()
                .tabItem{
                    Label("Статистика", systemImage:"chart.pie.fill")
                }
                .tag(1)
            ProfileView()
                .tabItem{
                    Label("Профиль", systemImage:"person.crop.circle")
                }
                .tag(2)
        }
        .tint(.yellow)
    }
}

#Preview {
    MainTabView()
}
