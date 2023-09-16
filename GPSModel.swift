//
//  GPSModel.swift
//  ShellHacks2023
//
//  Created by Yasaar Kadery on 9/16/23.
//

import MapKit
import Foundation

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 25.704100, longitude: -80.459520)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.0050, longitudeDelta: 0.0050)
}


final class GPSModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)
    @Published var averageSpeed: CLLocationSpeed = 0.0
    
    private var previousLocation: CLLocation?
    // function that gets periodically called to update the model with new GPS data
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
            guard let newLocation = locations.last else { return }
            
            // Update the region and average speed
            region = MKCoordinateRegion(center: newLocation.coordinate, span: MapDetails.defaultSpan)
            updateAverageSpeed(newLocation: newLocation)
        }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // handle any location errors
        if let locationError = error as? CLError {
            switch locationError.code {
            case .locationUnknown:
                print("Location is unknown or unavailable.")
            case .denied:
                print("Location services are denied. Please enable them in settings.")
            case .headingFailure:
                print("Heading updates are not available.")
            default:
                print("Location error: \(locationError.localizedDescription)")
            }
        } else {
            // Handle non-Core Location errors
            print("Non-Core Location error: \(error.localizedDescription)")
        }
    }

    
    // Method to calculate and update average speed
    private func updateAverageSpeed(newLocation: CLLocation) {
        guard let previousLocation = self.previousLocation else {
            self.previousLocation = newLocation
            return
        }
    
        let timeInterval = newLocation.timestamp.timeIntervalSince(previousLocation.timestamp)
        let distance = newLocation.distance(from: previousLocation)
        let speed = distance / timeInterval
        
        // Update the averageSpeed property and convert from m/s to mph
        averageSpeed = speed * 2.23694
        
        // Update previousLocation for the next calculation
        self.previousLocation = newLocation
    }
    func checkIfLocationServicesIsEnabled() {
        
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager!.delegate = self

        
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location is restricted")
        case .denied:
            print("Location servies are denied, go into app settings to change it")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDetails.defaultSpan)
            locationManager.startUpdatingLocation()
//            locationManager.distanceFilter = 10
            locationManager.activityType = .automotiveNavigation
        @unknown default:
            break
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

        checkLocationAuthorization()
    }


}
