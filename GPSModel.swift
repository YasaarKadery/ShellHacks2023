//
//  ContentViewModel.swift
//  SwiftUI-MapKit
//
//  Created by Yasaar Kadery on 9/12/23.
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
    @Published var shouldSlowDown: Bool = false
    private var previousLocation: CLLocation?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
            guard let newLocation = locations.last else { return }
            
            // Update the region and average speed
            region = MKCoordinateRegion(center: newLocation.coordinate, span: MapDetails.defaultSpan)
            updateAverageSpeed(newLocation: newLocation)
            guard let previousLocation = self.previousLocation else {
                self.previousLocation = newLocation
                return
            }

            // Calculate acceleration using the calculateAcceleration function
            let acceleration = calculateAcceleration(newLocation: newLocation, previousLocation: previousLocation)

            // Call the detectHardBrake method with acceleration
            detectHardBrake(acceleration: acceleration)

            // Update previousLocation for the next calculation
            self.previousLocation = newLocation
        }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let locationError = error as? CLError {
            switch locationError.code {
            case .locationUnknown:
                // Handle location being unknown or unavailable
                print("Location is unknown or unavailable.")
            case .denied:
                // Handle location services being denied by the user
                print("Location services are denied. Please enable them in settings.")
            case .headingFailure:
                // Handle issues with the compass or heading updates
                print("Heading updates are not available.")
            default:
                // Handle other location-related errors
                print("Location error: \(locationError.localizedDescription)")
            }
        } else {
            // Handle non-Core Location errors
            print("Non-Core Location error: \(error.localizedDescription)")
        }
    }
    func detectHardBrake(acceleration: CLLocationSpeed) {
        // Define a threshold for hard brakes (you can adjust this value)
        let hardBrakeThreshold: CLLocationSpeed = -5.0 // m/s^2

        if acceleration < hardBrakeThreshold {
            // A negative acceleration greater than the threshold indicates a hard brake
            self.shouldSlowDown.toggle()
        }

    }
    
    func calculateAcceleration(newLocation: CLLocation, previousLocation: CLLocation) -> CLLocationSpeed {
        // Calculate time interval between previous and new location
        let timeInterval = newLocation.timestamp.timeIntervalSince(previousLocation.timestamp)

        // Calculate change in speed
        let deltaSpeed = newLocation.speed - previousLocation.speed

        // Calculate acceleration (change in speed over time)
        let acceleration = deltaSpeed / timeInterval

        return acceleration
    }
    
    // Method to calculate and update average speed
    private func updateAverageSpeed(newLocation: CLLocation) {
        guard let previousLocation = self.previousLocation else {
            self.previousLocation = newLocation
            return
        }
        
        // Calculate time interval between previous and new location
        let timeInterval = newLocation.timestamp.timeIntervalSince(previousLocation.timestamp)
        
        // Calculate distance traveled between previous and new location
        let distance = newLocation.distance(from: previousLocation)
        
        // Calculate average speed
        let speed = distance / timeInterval
        
        // Update the averageSpeed property and convert from m/s to mph
        averageSpeed = speed * 2.23694
        
        // Update previousLocation for the next calculation
        self.previousLocation = newLocation
    }
    func checkIfLocationServicesIsEnabled() {
        
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
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
