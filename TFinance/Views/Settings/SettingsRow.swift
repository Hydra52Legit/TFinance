import SwiftUI

struct SettingsRow: View {
    let icon: String
    let color: Color
    let title: String
    let subtitle: String?
    let showsChevron: Bool

    init(icon: String, color: Color, title: String, subtitle: String? = nil, showsChevron: Bool = false) {
        self.icon = icon
        self.color = color
        self.title = title
        self.subtitle = subtitle
        self.showsChevron = showsChevron
    }

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.1))
                    .frame(width: 36, height: 36)
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(color)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body)
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
            if showsChevron {
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.gray.opacity(0.5))
            }
        }
        .padding(.vertical, 8)
    }
}
