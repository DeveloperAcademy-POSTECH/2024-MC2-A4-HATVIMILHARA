//
//  DoraeApp.swift
//  Dorae
//
//  Created by Damin on 5/18/24.
//

import SwiftUI
import SwiftData

@main
struct DoraeApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Pattern.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    

    var body: some Scene {
        WindowGroup {
            SplashView()
        }
        .modelContainer(sharedModelContainer)
    }
}
