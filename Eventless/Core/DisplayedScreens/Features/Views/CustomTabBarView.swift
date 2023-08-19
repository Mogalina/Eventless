// Define a custom tab bar view that presents tab options

// Imports and configuration
import SwiftUI

// Enumeration representing the available tabs in the custom tab bar
enum Tab: String, CaseIterable {
    case map = "map"
    case book = "book"
    case eye = "person.crop.circle"
}

struct CustomTabBarView: View {
    // Properties
    
    // Indicates the currently selected tab
    @Binding var selectedTab: Tab
    
    // Calculates the symbol name with '.fill' appended based on the selected tab
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(selectedTab == tab ? 1.25 : 1.00)
                        .foregroundColor(selectedTab == tab ? .white : .gray)
                        .font(.system(size: 20))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: nil, height: 70)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
        }
    }
}

// Provide a preview of the 'CustomTabBarView'
struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarView(selectedTab: .constant(.map))
            .preferredColorScheme(.dark)
    }
}
