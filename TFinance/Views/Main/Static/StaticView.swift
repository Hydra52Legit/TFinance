import SwiftUI

struct StaticView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Статистика")
                    .font(.title2)
                Text("Здесь будет экран статистики")
                    .foregroundStyle(.secondary)
            }
            .padding()
            .navigationTitle("Статистика")
        }
    }
}

#Preview {
    StaticView()
}
