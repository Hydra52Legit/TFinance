import SwiftUI

struct ProfileHeader: View {
    let userName: String
    let isPremium: Bool
    let onPremiumTap: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            // Аватар с иконкой камеры
            ZStack(alignment: .center) {
                
                Circle()
                    .fill(LinearGradient(
                        colors: [Color(.systemGray4), Color(.black)],
                        startPoint: .top,
                        endPoint: .bottom))
                    .frame(width: 96, height: 96)
                Image(systemName: "camera.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding(.top, 24)

            // Имя пользователя
            Text(userName)
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(.black)
                .padding(.top, 4)

            // PREMIUM-блок
            if isPremium == false {
                CardView(foreground: LinearGradient(
                    colors: [Color.blue.opacity(0.93), Color.black.opacity(0.95)],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )) {
                    VStack(spacing: 8) {
                        // Верхний ряд с бейджем
                        HStack {
                            Text("PREMIUM сервисы")
                                .font(.title3.bold())
                                .padding(.horizontal, 14)
                                .padding(.vertical, 6)
                                .background(
                                    Capsule()
                                        .fill(Color.blue)
                                )
                                .foregroundColor(.white)
                            Spacer()
                            Button(action: onPremiumTap) {
                                Text("Подробнее")
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(
                                        Capsule().fill(Color.white.opacity(0.18))
                                    )
                                    .foregroundColor(.white)
                            }
                        }
                        // Подзаголовок
                        HStack {
                            Text("Больше привилегий")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 4)
                }
                .padding(.top, 2)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 16)
//        .background(
//            LinearGradient(colors: [Color(.black), Color(.systemGray6)], startPoint: .top, endPoint: .bottom)
//                .ignoresSafeArea(edges: .top)
//        )
    }
}

// Пример превью
#Preview {
    ProfileHeader(userName: "Александр", isPremium: true, onPremiumTap: {})
}
