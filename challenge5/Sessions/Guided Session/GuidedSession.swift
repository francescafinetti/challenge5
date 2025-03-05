//INSERIRE VIBRAZIONI - SUONO - DUE BUTTON PER ATTIVARLI E DISATTIVARLI ANCHE QUI COME NELLA YOUR SESSION - CAMBIARE OMINO - END SESSION E SI DEVE TOGLIERE IL BACK


import SwiftUI

struct GuidedSession: View {
    let selectedPath: String
    @State private var textIndex = 0
    @State private var textTimer: Timer?
    @State private var fadeIn = false
    @State private var dotIndex = 0
    @State private var dotVisible = true
    @State private var imageFrame: CGRect = .zero  // Frame of image
    @State private var dotPositionX: Double = 0.0
    @State private var dotPositionY: Double = 0.0

    var currentTexts: [String] {
        selectedPath == "Top to Bottom" ? topToBottomTexts : bottomToTopTexts
    }

    var body: some View {
        VStack {
            ZStack {
                Image("man")
                    .resizable()
                    .scaledToFit()
                    .opacity(fadeIn ? 1 : 0)
                    .scaleEffect(fadeIn ? 1 : 0.9)
                    .animation(.easeInOut(duration: 1), value: fadeIn)
                    .overlay(GeometryReader { geometry in
                        Color.yellow
                            .opacity(0.5)
                            .onAppear {
                                updateImageFrame(using: geometry)
                            }
                            .onChange(of: geometry.frame(in: .named("ImageSpace"))) {
                                updateImageFrame(using: geometry)
                            }
                    })
                Circle()
                    .frame(width: 20, height: 20)
                    .opacity(dotVisible ? 1 : 0) // Controls fade in/out
                    .position(x: imageFrame.minX + imageFrame.width * topToBottomDot[dotIndex].0,
                              y: imageFrame.minY + imageFrame.height * topToBottomDot[dotIndex].1)
                Circle()
                    .frame(width: 20, height: 20)
                    .position(x: imageFrame.minX + imageFrame.width * 0,
                              y: imageFrame.minY + imageFrame.height * 0 )
                
                Circle()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.red)
                    .position(x: imageFrame.minX, y: imageFrame.minY)
                Circle()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.white)
                    .position(x: imageFrame.minX + imageFrame.width * 0.25,
                              y: imageFrame.minY + imageFrame.height * 0.25)
                Circle()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.cyan)
                    .position(x: imageFrame.midX, y: imageFrame.midY)
                
                Circle()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.white)
                    .position(x: imageFrame.minX + imageFrame.width * 0.75,
                              y: imageFrame.minY + imageFrame.height * 0.75)
                Circle()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.green)
                    .position(x: imageFrame.maxX, y: imageFrame.maxY)
                

            }
            .coordinateSpace(name: "ImageSpace")

               

            Text(currentTexts[textIndex])
                .foregroundColor(.white)
                .bold()
                .font(.body)
                .padding()
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .opacity(fadeIn ? 1 : 0)
                .scaleEffect(fadeIn ? 1 : 0.9)
                .transition(.opacity)
                .animation(.easeInOut(duration: 1), value: fadeIn)
                .padding(.bottom, 70)
                .padding(.horizontal, 20)

            Spacer()
        }
        .background(Color.black.ignoresSafeArea())
        .onAppear {
            fadeIn = true
            startTextTimer()
        }
        .onDisappear {
            textTimer?.invalidate()
        }
    }

    private func startTextTimer() {
        textTimer = Timer.scheduledTimer(withTimeInterval: 6, repeats: true) { _ in
            withAnimation {
                textIndex = (textIndex + 1) % currentTexts.count
            }
            withAnimation(.easeInOut(duration: 1)) {
                dotVisible = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                dotIndex = (dotIndex + 1) % topToBottomDot.count
                
                withAnimation(.easeInOut(duration: 1)) {
                    dotVisible = true
                }
            }
        }
    }
    private func updateImageFrame(using geometry: GeometryProxy) {
        imageFrame = geometry.frame(in: .named("ImageSpace"))
    }
}

#Preview {
    GuidedSession(selectedPath: "Top to Bottom")
}
