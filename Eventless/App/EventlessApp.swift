// Set up the app's entry point and define the main user interface 

// Imports and configuration
import SwiftUI

// Entry point of the app
@main
struct EventlessApp: App {
    let databaseManager = DatabaseManager.shared
    
    // Initializer of the app
    init() {
        databaseManager.initializeDatabase()
    }
    
    var body: some Scene {
        WindowGroup {
            // Root view of the app
            OpeningView()
                .preferredColorScheme(.dark)
        }
    }
}
