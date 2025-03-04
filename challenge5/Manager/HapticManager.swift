import CoreHaptics

class HapticManager {
    private var engine: CHHapticEngine?
    private var breathPlayer: CHHapticAdvancedPatternPlayer?
    private var isPlaying = false

    init() {
        prepareHaptics()
    }

    func prepareHaptics() {
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Haptic Engine Error: \(error.localizedDescription)")
        }
    }

    func startBreathingHaptic(intensity: String) {
        guard let engine = engine, !isPlaying else { return }
        isPlaying = true

        let intensityValue: Float
        switch intensity {
        case "Soft":
            intensityValue = 0.3
        case "Medium":
            intensityValue = 0.6
        case "Strong":
            intensityValue = 1.0
        default:
            intensityValue = 0.6
        }

        func playHapticPattern() {
            do {
                let pattern = try CHHapticPattern(events: [
                    CHHapticEvent(eventType: .hapticContinuous, parameters: [
                        CHHapticEventParameter(parameterID: .hapticIntensity, value: intensityValue * 0.2),
                        CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
                    ], relativeTime: 0, duration: 1),

                    CHHapticEvent(eventType: .hapticContinuous, parameters: [
                        CHHapticEventParameter(parameterID: .hapticIntensity, value: intensityValue * 0.5),
                        CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.4)
                    ], relativeTime: 1, duration: 1),

                    CHHapticEvent(eventType: .hapticContinuous, parameters: [
                        CHHapticEventParameter(parameterID: .hapticIntensity, value: intensityValue),
                        CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.6)
                    ], relativeTime: 2, duration: 2),

                    CHHapticEvent(eventType: .hapticTransient, parameters: [
                        CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.0)
                    ], relativeTime: 4.2, duration: 0),

                    CHHapticEvent(eventType: .hapticContinuous, parameters: [
                        CHHapticEventParameter(parameterID: .hapticIntensity, value: intensityValue),
                        CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.6)
                    ], relativeTime: 5, duration: 2),

                    CHHapticEvent(eventType: .hapticContinuous, parameters: [
                        CHHapticEventParameter(parameterID: .hapticIntensity, value: intensityValue * 0.5),
                        CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.4)
                    ], relativeTime: 7, duration: 2),

                    CHHapticEvent(eventType: .hapticContinuous, parameters: [
                        CHHapticEventParameter(parameterID: .hapticIntensity, value: intensityValue * 0.2),
                        CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
                    ], relativeTime: 9, duration: 2),

                    CHHapticEvent(eventType: .hapticTransient, parameters: [
                        CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.0)
                    ], relativeTime: 11.2, duration: 0)
                ], parameters: [])

                breathPlayer = try engine.makeAdvancedPlayer(with: pattern)
                try breathPlayer?.start(atTime: 0)

                DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
                    if self.isPlaying {
                        playHapticPattern()
                    }
                }

            } catch {
                print("Failed to create haptic pattern: \(error.localizedDescription)")
            }
        }

        playHapticPattern()
    }

    func stopBreathingHaptic() {
        isPlaying = false
        do {
            try breathPlayer?.stop(atTime: 0)
        } catch {
            print("Failed to stop haptic: \(error.localizedDescription)")
        }
    }
}
