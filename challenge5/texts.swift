import SwiftUI

struct IntertwinedCirclesView: View {
    @State private var animate = false
    @State private var textIndex = 0
    let texts = ["prima frase...", "seconda frase...", "terza frase...", "quarta frase..."]
    
    var body: some View {
            VStack {
                ZStack {
                    Color.black.ignoresSafeArea()
                    
                    ForEach(0..<2, id: \..self) { i in
                        Circle()
                            .fill(RadialGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.7), Color.orange.opacity(0.8), Color.red.opacity(0.9), Color.white.opacity(0.6)]),
                                                 center: .center, startRadius: 10, endRadius: 120))
                            .frame(width: animate ? 150 : 80, height: animate ? 150 : 80)
                            .offset(x: animate ? CGFloat(i * 80 - 40) : CGFloat(-i * 80 + 40),
                                    y: animate ? CGFloat(i * -40 + 20) : CGFloat(i * 40 - 20))
                            .rotationEffect(.degrees(animate ? 360 : 0))
                            .scaleEffect(animate ? 1.4 : 0.7)
                            .animation(Animation.easeInOut(duration: 6).repeatForever(autoreverses: true), value: animate)
                            .blur(radius: animate ? 15 : 5)
                            .opacity(animate ? 0.9 : 0.6)
                            .overlay(
                                Circle()
                                    .stroke(Color.white.opacity(0.2), lineWidth: 2)
                                    .scaleEffect(animate ? 1.6 : 1)
                                    .animation(Animation.easeInOut(duration: 6).repeatForever(autoreverses: true), value: animate)
                            )
                    }
                    
                    ForEach(0..<2, id: \..self) { i in
                        Circle()
                            .fill(RadialGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.7), Color.orange.opacity(0.8)]),
                                                 center: .center, startRadius: 10, endRadius: 100))
                            .frame(width: animate ? 120 : 60, height: animate ? 120 : 60)
                            .offset(x: animate ? CGFloat(i * 70 - 35) : CGFloat(-i * 70 + 35),
                                    y: animate ? CGFloat(i * 35 - 20) : CGFloat(-i * 35 + 20))
                            .rotationEffect(.degrees(animate ? 360 : 0))
                            .scaleEffect(animate ? 1.4 : 0.7)
                            .animation(Animation.easeInOut(duration: 6).repeatForever(autoreverses: true), value: animate)
                            .blur(radius: animate ? 10 : 3)
                            .opacity(animate ? 0.8 : 0.5)
                        
                    }
                }
                .onAppear {
                    animate.toggle()
                    Timer.scheduledTimer(withTimeInterval: 6, repeats: true) { timer in
                        textIndex = (textIndex + 1) % texts.count
                    }
                }
                
                Text(texts[textIndex])
                    .foregroundColor(.white)
                    .font(.body)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 3), value: textIndex)
            }
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            IntertwinedCirclesView()
        }
    }
