import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage("username") private var username: String = "example"
    @State private var notificationsEnabled: Bool = true
    @State private var notificationTime: Date = Date()
    @State private var selectedLanguage: String = "English (USA)"
    @State private var showingDatePicker = false
    @State private var showingLanguagePicker = false
    
    let languages = ["Italiano", "English (USA)", "Français", "Español"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("HOW WOULD YOU LIKE TO BE CALLED?").font(.caption).foregroundColor(.gray)) {
                    TextField("Enter your name", text: $username)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                }
                
                Section {
                    Toggle(isOn: $notificationsEnabled) {
                        Text("Notification")
                    }
                    
                    if notificationsEnabled {
                        HStack {
                            Text("Notification Time")
                            Spacer()
                            Button(action: {
                                showingDatePicker.toggle()
                            }) {
                                Text(notificationTime, style: .time)
                                    .foregroundColor(.blue)
                            }
                        }
                        
                        if showingDatePicker {
                            DatePicker("Select Time", selection: $notificationTime, displayedComponents: .hourAndMinute)
                                .datePickerStyle(WheelDatePickerStyle())
                                .labelsHidden()
                        }
                    }
                }
                
                Section {
                    HStack {
                        Text("Language")
                        Spacer()
                        Button(action: {
                            showingLanguagePicker.toggle()
                        }) {
                            Text(selectedLanguage)
                                .foregroundColor(.blue)
                        }
                    }
                    
                    if showingLanguagePicker {
                        Picker("Select Language", selection: $selectedLanguage) {
                            ForEach(languages, id: \.self) { language in
                                Text(language)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                }
                
                Section {
                    NavigationLink(destination: InfoView()) {
                        Text("Info")
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
    }
}

struct InfoView: View {
    var body: some View {
        Text("Welcome to [App Name], a space designed to support individuals who are navigating body dysmorphia with self-awareness and a desire for change. Our mission is to help you cultivate a healthier connection with your body through self-compassion, body-focused exercises, and mindful practices.Inspired by research on self-compassion and supportive touch, our approach encourages gentle, non-judgmental engagement with your body, helping you shift towards a more balanced and appreciative self-perception. While we are not medical professionals, our methods are rooted in scientific studies that emphasize kindness, acceptance, and connection as tools for well-being. This journey is personal, and progress looks different for everyone. Whether you're taking your first step or deepening your practice, [App Name] is here to guide you in fostering a more positive and compassionate relationship with yourself. You are worthy of kindness—especially from yourself. ")
        Spacer()
            .navigationTitle("Info")

    }
}

#Preview {
    SettingsView()
}
