//
//  DoraeApp.swift
//  Dorae
//
//  Created by Damin on 5/18/24.
//

import SwiftUI
import SwiftData
import Mixpanel

@main
struct DoraeApp: App {
    @State private var knotDataManager = KnotDataManager()

    init() {
        // Mixpanel token
        Mixpanel.initialize(token: "c3edd3f4d7a35aa2e22274bb71f7ee68", trackAutomaticEvents: true)
    }
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
//            Item.self,
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
        .environment(knotDataManager)
        .modelContainer(sharedModelContainer)
    }
}
