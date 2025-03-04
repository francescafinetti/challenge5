import SwiftUI
import CoreHaptics

struct IntertwinedCirclesView: View {
    @State private var animate = false
    @State private var textIndex = 0
    @State private var textTimer: Timer?

    var hapticManager: HapticManager


    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()

                ForEach(0..<2, id: \.self) { i in
                    Circle()
                        .fill(RadialGradient(gradient: Gradient(colors: [
                            Color.yellow.opacity(0.7),
                            Color.orange.opacity(0.8),
                            Color.red.opacity(0.9),
                            Color.white.opacity(0.6)
                        ]), center: .center, startRadius: 10, endRadius: 120))
                        .frame(width: animate ? 150 : 80, height: animate ? 150 : 80)
                        .offset(x: animate ? CGFloat(i * 80 - 40) : CGFloat(-i * 80 + 40),
                                y: animate ? CGFloat(i * -40 + 20) : CGFloat(i * 40 - 20))
                        .rotationEffect(.degrees(animate ? 360 : 0))
                        .scaleEffect(animate ? 1.4 : 0.7)
                        .blur(radius: animate ? 15 : 5)
                        .opacity(animate ? 0.9 : 0.6)
                        .animation(Animation.easeInOut(duration: 6).repeatForever(autoreverses: true), value: animate)
                        .overlay(
                            Circle()
                                .stroke(Color.yellow.opacity(0.1), lineWidth: 2)
                                .scaleEffect(animate ? 1.6 : 1)
                                .animation(Animation.easeInOut(duration: 6).repeatForever(autoreverses: true), value: animate)
                        )
                        .overlay(
                            Circle()
                                .stroke(Color.yellow.opacity(0.1), lineWidth: 2)
                                .scaleEffect(animate ? 2.2 : 1)
                                .animation(Animation.easeInOut(duration: 6).repeatForever(autoreverses: true), value: animate)
                        )
                }
            }
            .onAppear {
                animate.toggle()
                startTextTimer()
            }
            .onDisappear {
                textTimer?.invalidate()
                hapticManager.stopBreathingHaptic()
            }

            Text(texts[textIndex])
                .foregroundColor(.white)
                .bold()
                .font(.body)
                .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 70) 
                .multilineTextAlignment(.center)
                .transition(.opacity)
                .animation(.easeInOut(duration: 3), value: textIndex)
                .padding(.bottom, 70)
                .padding(.horizontal, 20)
        }
    }

    private func startTextTimer() {
        textTimer = Timer.scheduledTimer(withTimeInterval: 6, repeats: true) { _ in
            withAnimation {
                textIndex = (textIndex + 1) % texts.count
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        IntertwinedCirclesView(hapticManager: HapticManager())
    }
}
