// Define a 'LocationManager' class that uses 'CoreLocation' to manage the user's current location

// Imports and configuration
import CoreLocation
import MapKit
import SwiftUI

// Defined as a subclass of 'NSObject' and conforms to the 'ObservableObject' protocol,
// allowing it to publish changes to its properties
class LocationManager: NSObject, ObservableObject {
    // Properties
    
    // Handle location-related tasks
    private let locationManager = CLLocationManager()
    
    // Store the user's current location
    @Published var userLocation: CLLocationCoordinate2D?

    // Handle location updates
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    // Return the user's current location
    func getCurrentLocation(completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        if let userLocation = userLocation {
            completion(.success(userLocation))
        } else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Location not available"])))
        }
    }
}

// Handle location updates
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last?.coordinate else { return }
        self.userLocation = userLocation
        
        // Location manager is stopped from further updates to conserve resources
        locationManager.stopUpdatingLocation()
    }
}
