import SwiftUI

struct CardView<Content: View>: View {
    let content: Content
    let foreground: AnyShapeStyle
    
    init(foreground: some ShapeStyle = Color(.systemBackground),
         @ViewBuilder content: () -> Content) {
        self.foreground = AnyShapeStyle(foreground)
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(foreground)
            )
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 0)
            .padding(.horizontal)
    }
}
