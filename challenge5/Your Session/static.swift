import SwiftUI

struct StaticIntertwinedCirclesView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ForEach(0..<2, id: \.self) { i in
                Circle()
                    .fill(RadialGradient(gradient: Gradient(colors: [
                        Color.yellow.opacity(0.7),
                        Color.orange.opacity(0.8),
                        Color.red.opacity(0.9),
                        Color.white.opacity(0.6)
                    ]), center: .center, startRadius: 10, endRadius: 150))
                    .frame(width: 160, height: 160)
                    .offset(x: CGFloat(i * 70 - 35), y: CGFloat(i * -20 + 10))
                    .blur(radius: 10)
                    .opacity(0.85)
                    .overlay(
                        Circle()
                            .stroke(Color.yellow.opacity(0.2), lineWidth: 3)
                            .scaleEffect(1.5)
                    )
                    .overlay(
                        Circle()
                            .stroke(Color.orange.opacity(0.15), lineWidth: 2)
                            .scaleEffect(2.0)
                    )
            }
        }
    }
}

#Preview {
    StaticIntertwinedCirclesView()
}
