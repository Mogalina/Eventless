// Create and configure a MapKit-based map view within a SwiftUI app.
// It handles annotation display, selection and customization, as well as user location tracking.

// Imports and configuration
import SwiftUI
import MapKit

// Array to hold annotations as events from database - DatabaseManager
let annotations = DatabaseManager.shared.getEvents(sortedBy: DatabaseManager.shared.name)

// Configure map
// Conforms to the 'UIViewRepresentable' protocol, allowing it to create and manage a UIKit-based view in SwiftUI
struct MapViewRepresentable: UIViewRepresentable {
    // Properties
    
    // Holds an instance of 'MapViewModel'
    @ObservedObject var mapViewModel = MapViewModel.shared
    
    // Indicates whether the map should be centered on the user's location
    @Binding var pointToUserLocationIsActive: Bool
    
    // Instance of 'MKMapView'
    let mapView = MKMapView()
    
    // Instance of 'LocationManager'
    let locationManager = LocationManager()
    
    // Create and configure the map view
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        // Add annotations
        updateMapWithAnnotations(annotations)

        return mapView
    }
    
    // Update map view corresponding to user preferences
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let selectedAnnotation = mapViewModel.selectedAnnotation {
            // Zoom in on the selected annotation
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: selectedAnnotation.latitude, longitude: selectedAnnotation.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )

            withAnimation(.easeInOut(duration: 0.5)) {
                mapView.setRegion(region, animated: true)
            }
        }
        
        // Check if the flag is active: zoom in on the selected annotation
        if pointToUserLocationIsActive {
            // Center map on user's location
            if let userLocation = mapView.userLocation.location?.coordinate {
                let region = MKCoordinateRegion(
                    center: userLocation,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
                
                withAnimation(.easeInOut(duration: 0.5)) {
                    mapView.setRegion(region, animated: true)
                }
            }
        }
    }
    
    // Update the map with the provided annotations
    func updateMapWithAnnotations(_ annotations: [AnnotationModel]) {
        mapView.removeAnnotations(mapView.annotations) // Clear existing annotations

        // Creates and adds 'MKPointAnnotation' instances to the map using data from the annotations array
        addAnnotationsToMap(annotations: annotations)
    }

    // Returns a custom class - MapCoordinator
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }

    // Creates and adds 'MKPointAnnotation' instances to the map using data from the annotations array
    func addAnnotationsToMap(annotations: [AnnotationModel]) {
        for annotationData in annotations {
            let latitude = annotationData.latitude
            let longitude = annotationData.longitude
            let annotationName = annotationData.annotationName

            // Create coordinate
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

            // Create annotation
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = annotationName

            // Add annotation to map
            mapView.addAnnotation(annotation)
        }
    }

    // Custom annotation customization
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent: MapViewRepresentable

        init(parent: MapViewRepresentable) {
            self.parent = parent
            super.init()
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            }

            let annotationIdentifier = "CustomAnnotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MKMarkerAnnotationView

            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                annotationView?.canShowCallout = false // Remove info button
            } else {
                annotationView?.annotation = annotation
            }

            // Set a custom tint color for the marker
            annotationView?.markerTintColor = .gray

            // Set a custom image for the marker (replace with your image name)
            let customImage = UIImage(named: "")
            annotationView?.glyphImage = customImage

            return annotationView
        }
        
        // Center the map on the user's location when it updates
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,
                                               longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            parent.mapView.setRegion(region, animated: true)
        }
    }
}
