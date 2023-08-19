// Define the main structure of the app's user interface, utilizing a custom tab bar to navigate between different sections

// Imports and configuration
import SwiftUI

struct MainView: View {
    // Properties
    
    // Keep track of the currently selected tab
    @State private var selectedTab: Tab = .map
    
    // Hide the native tab bar appearance for this view
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            VStack {
                switch selectedTab {
                    case .map:
                        ViewMap()
                    case .book:
                        ViewEvents()
                    case .eye:
                        ViewProfile()
                }
            }
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                CustomTabBarView(selectedTab: $selectedTab)
            }
            .ignoresSafeArea()
        }
    }
}

// Provide a preview of the 'MainView'
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}
