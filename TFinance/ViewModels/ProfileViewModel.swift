import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var userData: UserData?
    
    struct UserData: Codable, Identifiable {
        let id: UUID
        let name: String
        let email: String
        let phone: String
        let joinDate: Date
        let premiumUntil: Date?
        
        // Кастомный декодер — всегда присваивает новый UUID
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try container.decode(String.self, forKey: .name)
            self.email = try container.decode(String.self, forKey: .email)
            self.phone = try container.decode(String.self, forKey: .phone)
            self.joinDate = try container.decode(Date.self, forKey: .joinDate)
            self.premiumUntil = try container.decodeIfPresent(Date.self, forKey: .premiumUntil)
            self.id = UUID()
        }
        
        // Ваш инициализатор для ручного создания
        init(name: String, email: String, phone: String, joinDate: Date, premiumUntil: Date?) {
            self.id = UUID()
            self.name = name
            self.email = email
            self.phone = phone
            self.joinDate = joinDate
            self.premiumUntil = premiumUntil
        }
        
        private enum CodingKeys: String, CodingKey {
            case name, email, phone, joinDate, premiumUntil
        }
    }
    
    init(){
        loadUserData()
    }
    
    func loadUserData() {
        isLoading = true
        // Имитация сетевого запроса
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.userData = UserData(
                name: "Александр Петров",
                email: "alex.petrov@example.com",
                phone: "+7 (999) 123-45-67",
                joinDate: Date().addingTimeInterval(-365*24*60*60),
                premiumUntil: Date().addingTimeInterval(30*24*60*60)
            )
            self.isLoading = false
        }
    }
    
    func logout() {
        // Логика выхода из аккаунта
        print("Выход из аккаунта...")
    }
}
