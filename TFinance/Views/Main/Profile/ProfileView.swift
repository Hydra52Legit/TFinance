import SwiftUI

struct ProfileView: View {
    @State private var isOpen: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ProfileHeader(
                        userName: "Александр",
                        isPremium: false,
                        onPremiumTap: {}
                    )
                    
                    
                    CardView(
                        foreground: LinearGradient(
                            colors: [Color.yellow.opacity(0.93), Color.black.opacity(0.95)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    ) {
                        VStack(spacing: 16) {
                            // Заголовок
                            HStack(spacing: 12) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Профиль в плюсе")
                                        .font(.title2.bold())
                                        .foregroundColor(.white)
                                    
                                    Text("Соцсеть про деньги и лайфстайл")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.8))  // Исправлен opacity
                                        .padding(.top, 2)
                                }
                                
                                Spacer()
                            }
                            
                            // Кнопка
                            Button(action: {
                                print("Переход в Профиль Плюс")
                            }) {
                                Text("Создать профиль")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(
                                        Capsule()
                                            .fill(Color.white)
                                    )
                            }
                        }
                    }
                    
                }
                .padding(.vertical)  // Вертикальные отступы
            }
            .navigationTitle("Профиль")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isOpen = true }) {
                        Image(systemName: "gearshape")
                            .foregroundColor(.blue)
                    }
                }
            }
            
        }.sheet(isPresented: $isOpen){
            SettingsView()
        }
    }
}

#Preview {
    ProfileView()
        
}
