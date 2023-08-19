// Serves as a centralized source of truth for managing map-related state,
// specifically the currently selected annotation

// Imports and configuration
import SwiftUI
import Combine

class MapViewModel: ObservableObject {
    // Properties
    static let shared = MapViewModel()
    
    // Represents currently selected annotation on the map
    @Published var selectedAnnotation: AnnotationModel? = nil

    // Set the currently selected annotation on the map
    func selectAnnotation(_ annotation: AnnotationModel) {
        selectedAnnotation = annotation
    }
}
