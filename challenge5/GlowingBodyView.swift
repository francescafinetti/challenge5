import SwiftUI

struct FluidHumanFigureView: View {
    @State private var activeStep = 0
    @State private var glowEffect = false
    
    let steps: [(id: Int, position: (x: CGFloat, y: CGFloat), text: String, duration: Double)] = [
        (0, (0.5, 0.2), "Sfiora delicatamente la tua guancia.", 3.5),
        (1, (0.5, 0.3), "Porta una mano sul cuore, sentine il calore.", 3.5),
        (2, (0.5, 0.4), "Appoggia una mano sull’addome e rilassati.", 3.5),
        (3, (0.35, 0.5), "Posa le mani sulle spalle e respira.", 4.0),
        (4, (0.5, 0.6), "Incrocia le braccia e abbracciati con dolcezza.", 4.0)
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Sfondo con gradienti dinamici e effetto nebuloso
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.purple.opacity(0.3), Color.black]),
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    RadialGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.clear]),
                                   center: .center, startRadius: 50, endRadius: 400)
                        .blur(radius: 50)
                )
                
                // Figura umana stilizzata con effetto respiro
                HumanOutline()
                    .stroke(Color.white.opacity(0.4), lineWidth: 3)
                    .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.8)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    .shadow(color: glowEffect ? .cyan.opacity(0.6) : .clear, radius: glowEffect ? 20 : 5)
                    .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: glowEffect)
                    .onAppear {
                        glowEffect.toggle()
                        advanceStep()
                    }
                
                // Punti interattivi per il tocco con effetto pulsante
                ForEach(steps, id: \.id) { step in
                    let position = CGPoint(
                        x: step.position.x * geometry.size.width,
                        y: step.position.y * geometry.size.height
                    )

                    Circle()
                        .fill(activeStep == step.id ? Color.cyan.opacity(1) : Color.white.opacity(0.3))
                        .frame(width: activeStep == step.id ? 40 : 25, height: activeStep == step.id ? 40 : 25)
                        .position(position)
                        .shadow(color: .cyan, radius: activeStep == step.id ? 20 : 8)
                        .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: activeStep)
                }

                // Istruzioni testuali con effetto dissolvenza
                VStack {
                    Spacer()
                    Text(steps[activeStep].text)
                        .font(.title2)
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .transition(.opacity)
                        .padding(.horizontal, 30)
                }
                .padding(.bottom, 60)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    // Funzione che fa avanzare automaticamente la sessione
    private func advanceStep() {
        if activeStep < steps.count - 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + steps[activeStep].duration) {
                withAnimation {
                    activeStep += 1
                }
                advanceStep()
            }
        }
    }
}

// Struttura della figura umana stilizzata con linee più fluide
struct HumanOutline: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.width
        let height = rect.height

        // Testa
        path.addEllipse(in: CGRect(x: width * 0.42, y: height * 0.05, width: width * 0.16, height: width * 0.16))
        
        // Collo
        path.move(to: CGPoint(x: width * 0.5, y: height * 0.21))
        path.addLine(to: CGPoint(x: width * 0.5, y: height * 0.3))
        
        // Spalle e Braccia curve
        path.move(to: CGPoint(x: width * 0.5, y: height * 0.3))
        path.addCurve(to: CGPoint(x: width * 0.25, y: height * 0.5),
                      control1: CGPoint(x: width * 0.45, y: height * 0.4),
                      control2: CGPoint(x: width * 0.3, y: height * 0.45))
        
        path.move(to: CGPoint(x: width * 0.5, y: height * 0.3))
        path.addCurve(to: CGPoint(x: width * 0.75, y: height * 0.5),
                      control1: CGPoint(x: width * 0.55, y: height * 0.4),
                      control2: CGPoint(x: width * 0.7, y: height * 0.45))
        
        // Corpo fluido
        path.move(to: CGPoint(x: width * 0.5, y: height * 0.3))
        path.addCurve(to: CGPoint(x: width * 0.5, y: height * 0.75),
                      control1: CGPoint(x: width * 0.4, y: height * 0.5),
                      control2: CGPoint(x: width * 0.6, y: height * 0.6))
        
        return path
    }
}

#Preview {
    FluidHumanFigureView()
}
