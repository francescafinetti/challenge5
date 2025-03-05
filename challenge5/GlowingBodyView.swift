import SwiftUI

struct FluidHumanFigureView: View {
    @State private var activeStep = 0
    @State private var glowEffect = false
    @State private var dotVisible = true
    var instructionVM = InstructionViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Sfondo con gradienti dinamici e effetto nebuloso
                LinearGradient(
                    gradient: Gradient(colors: [Color.yellow.opacity(0.5), Color.orange.opacity(0.3), Color.black]),
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    RadialGradient(gradient: Gradient(colors: [Color.orange.opacity(0.3), Color.clear]),
                                   center: .center, startRadius: 50, endRadius: 400)
                        .blur(radius: 50)
                )
                
                // Figura umana stilizzata con effetto respiro
                HumanOutline()
                    .stroke(Color.white.opacity(0.4), lineWidth: 3)
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.9)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    .shadow(color: glowEffect ? .cyan.opacity(0.6) : .clear, radius: glowEffect ? 20 : 5)
                    .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: glowEffect)
                    .onAppear {
                        glowEffect.toggle()
                        advanceStep()
                    }
                
                // Posizione del cerchio in base all'istruzione corrente
                let position = CGPoint(
                    x: instructionVM.instructions[activeStep].position.x * geometry.size.width,
                    y: instructionVM.instructions[activeStep].position.y * geometry.size.height
                )
                
                // Cerchio che appare e scompare in base a activeStep
                Circle()
                    .fill(Color.orange.opacity(1))
                    .frame(width: 40, height: 40)
                    .position(position)
                    .opacity(dotVisible ? 1: 0 )
                    .animation(.easeInOut(duration: 1), value: dotVisible)
                

                // Istruzioni testuali con effetto dissolvenza
                VStack {
                    Spacer()
                    Text(instructionVM.instructions[activeStep].text)
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
        if activeStep < instructionVM.instructions.count - 1 {
            withAnimation (.easeInOut(duration: 1)){
                dotVisible = false
                
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + instructionVM.instructions[activeStep].duration) {
                 activeStep += 1
                
                advanceStep()
            }
            withAnimation(.easeInOut(duration: 1)) {
                
                dotVisible = true
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
        path.addEllipse(in: CGRect(x: width * 0.40, y: height * 0.10, width: width * 0.20, height: width * 0.20))
        
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
