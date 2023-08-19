// Combine a map display and user interface elements.
// Represents a part of an app that displays a map with various
// functionalities, possibly centered around user location and map-related actions.

// Imports and configuration
import SwiftUI

struct ViewMap: View {
    // Properties
    @State private var pointToUserLocationIsActive = false
    
    var body: some View {
        ZStack {
            // Display the actual map
            // 'pointToUserLocationIsActive' property is passed to it as a binding,
            // allowing the map to react to changes in this state variable
            MapViewRepresentable(pointToUserLocationIsActive: $pointToUserLocationIsActive)
                // Ensure that the map takes up the entire screen without respecting safe area insets
                .ignoresSafeArea()
            HStack {
                Spacer()
                VStack {
                    // Provide user interface elements related to map features
                    ViewMapFeaturesView(pointToUserLocationIsActive: $pointToUserLocationIsActive)
                    Spacer()
                }
                .padding(.trailing, 12)
                .padding(.top, 85)
            }
        }
    }
}

// Provide a preview of the 'ViewMap'
struct ViewMap_Previews: PreviewProvider {
    static var previews: some View {
        ViewMap()
            .preferredColorScheme(.dark)
    }
}
