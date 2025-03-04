//
//  challenge5App.swift
//  challenge5
//
//  Created by Francesca Finetti on 24/02/25.
//

import SwiftUI
import SwiftData

@main
struct challenge5App: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    init() {
        // Forza il tema scuro per l'intera app
        UIView.appearance().overrideUserInterfaceStyle = .dark
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark) // Imposta la modalità scura
        }
        .modelContainer(sharedModelContainer)
    }
}
