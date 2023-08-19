// 'AnnotationModel' class is designed to hold information about annotations on a map

// Imports and configuration
import SwiftUI
import MapKit
import Foundation

// Model for annotations placed on a map
// The 'Identifiable' protocol requires that instances of the class have a unique identifier
// The 'Equatable' protocol by implementing the == (equality) operator function
class AnnotationModel: Identifiable, Equatable {
    // Properties
    public var latitude: CLLocationDegrees = 0.0
    public var longitude: CLLocationDegrees = 0.0
    public var annotationName: String = ""
    public var mainCategory: String = ""
    public var derivedCategory: String = ""
    public var startDate: String = ""
    public var endDate: String = ""
    public var description: String = ""
    
    // Define how two instances of 'AnnotationModel' should be compared for equality (by 'annotationName')
    static func == (lhs: AnnotationModel, rhs: AnnotationModel) -> Bool {
        return lhs.annotationName == rhs.annotationName
    }
}
