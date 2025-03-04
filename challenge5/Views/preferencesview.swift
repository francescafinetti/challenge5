import SwiftUI

struct PreferencesView: View {
    @Environment(\.presentationMode) var presentationMode

    @AppStorage("soundEnabled") private var soundEnabled: Bool = true
    @AppStorage("selectedSound") private var selectedSound: String = "Default"
    @AppStorage("vibrationEnabled") private var vibrationEnabled: Bool = true
    @AppStorage("selectedVibrationIntensity") private var selectedVibrationIntensity: String = "Medium"

    @State private var isSoundMenuExpanded: Bool = false

    let soundOptions = ["None", "Forest", "Meditation", "Melody", "Piano", "Rain", "Relaxing", "Sea", "Yoga"]

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Sound Settings")) {
                    Toggle("Sound", isOn: $soundEnabled)
                        .tint(Color.accent1)

                    if soundEnabled {
                        DisclosureGroup(
                            isExpanded: $isSoundMenuExpanded,
                            content: {
                                ForEach(soundOptions, id: \.self) { sound in
                                    HStack {
                                        Text(sound)
                                        Spacer()
                                        if selectedSound == sound {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(Color.accent1)
                                        }
                                    }
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        selectedSound = sound
                                        SoundManager.shared.playSound(named: sound)
                                        isSoundMenuExpanded = false
                                    }
                                }
                            },
                            label: {
                                HStack {
                                    Text("Sound Type")
                                    Spacer()
                                    Image(systemName: isSoundMenuExpanded ? "chevron.down" : "chevron.right")
                                        .foregroundColor(.gray)
                                    
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    withAnimation {
                                        isSoundMenuExpanded.toggle()
                                    }
                                }
                            }
                        )
                    }
                }

                Section(header: Text("Vibration Settings")) {
                    Toggle("Vibration", isOn: $vibrationEnabled)
                        .tint(Color.accent1)

                    if vibrationEnabled {
                        Picker("Vibration Intensity", selection: $selectedVibrationIntensity) {
                            ForEach(["Soft", "Medium", "Strong"], id: \.self) { intensity in
                                Text(intensity)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
            }
            .navigationTitle("Preferences")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
        .accentColor(Color("Accent1"))
    }
}

#Preview {
    PreferencesView()
}
