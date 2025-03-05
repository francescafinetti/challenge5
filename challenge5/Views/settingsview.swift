import SwiftUI
import UserNotifications

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage("username") private var username: String = "example"
    @State private var notificationsEnabled: Bool = true
    @State private var notificationTime: Date = Date()
    @State private var selectedLanguage: String = "English (USA)"
    @State private var showingDatePicker = false
    @State private var showingLanguagePicker = false
    
    @AppStorage("soundEnabled") private var soundEnabled: Bool = true
    @AppStorage("selectedSound") private var selectedSound: String = "Default"
    @AppStorage("vibrationEnabled") private var vibrationEnabled: Bool = true
    @AppStorage("selectedVibrationIntensity") private var selectedVibrationIntensity: String = "Medium"
    
    @State private var isSoundMenuExpanded: Bool = false
    
    let soundOptions = ["None", "Forest", "Meditation", "Melody", "Piano", "Rain", "Relaxing", "Ocean", "Yoga"]
    let languages = ["Italiano", "English (USA)", "Français", "Español"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("HOW WOULD YOU LIKE TO BE CALLED?").font(.caption).foregroundColor(.gray)) {
                    TextField("Enter your name", text: $username)
                        .cornerRadius(8)
                }
                
                Section(header: Text("Sound Settings")) {
                    Toggle("Sound", isOn: $soundEnabled)
                        .tint(Color.accent1)
                    
                    if soundEnabled {
                        DisclosureGroup(
                            isExpanded: $isSoundMenuExpanded,
                            content: {
                                ForEach(soundOptions, id: \ .self) { sound in
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
                            ForEach(["Soft", "Medium", "Strong"], id: \ .self) { intensity in
                                Text(intensity)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                
                Section(header: Text("Notification Settings")) {
                    Toggle("Notification", isOn: $notificationsEnabled)
                        .tint(Color.accent1)
                        .onChange(of: notificationsEnabled) { newValue in
                            if newValue {
                                requestNotificationPermission()
                            } else {
                                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                            }
                        }
                    
                    if notificationsEnabled {
                        HStack {
                            Text("Notification Time")
                            Spacer()
                            Button(action: {
                                showingDatePicker.toggle()
                            }) {
                                Text(notificationTime, style: .time)
                                    .foregroundColor(.accent1)
                            }
                        }
                        
                        if showingDatePicker {
                            DatePicker("Select Time", selection: $notificationTime, displayedComponents: .hourAndMinute)
                                .datePickerStyle(WheelDatePickerStyle())
                                .labelsHidden()
                                .onChange(of: notificationTime) { _ in
                                    if notificationsEnabled {
                                        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["dailyNotification"])
                                        scheduleNotification(title: "Hey, \(username)! ⏰", body: "Time for your session!", notificationTime: notificationTime)
                                    }
                                }
                        }
                    }
                }
                
                Section(header: Text("Language Settings")) {
                    HStack {
                        Text("Language")
                        Spacer()
                        Button(action: {
                            showingLanguagePicker.toggle()
                        }) {
                            Text(selectedLanguage)
                                .foregroundColor(.accent1)
                        }
                    }
                    
                    if showingLanguagePicker {
                        Picker("Select Language", selection: $selectedLanguage) {
                            ForEach(languages, id: \ .self) { language in
                                Text(language)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                }
                
                Section {
                    NavigationLink(destination: InfoView()) {
                        Text("About")
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarItems(trailing: Button("Done") {
                UserDefaults.standard.set(username, forKey: "username")
                UserDefaults.standard.set(selectedLanguage, forKey: "selectedLanguage")
                presentationMode.wrappedValue.dismiss()
            })
        }
        .accentColor(Color.accent1)
    }
    
    }

#Preview {
    SettingsView()
}
