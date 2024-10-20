//
//  MapViewModel.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/20/24.
//

import Foundation

import SwiftUI
import MapKit
import CoreLocation

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    static var shared: MapViewModel = MapViewModel()
    
    /// Default to San Francisco
    @Published var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
    )
    
    @Published var comicBookStores: [ComicBookStore] = []
    
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        
        retrieveUserLocation()
    }
    
    func retrieveUserLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func fetchNearbyStores() {
        DispatchQueue.main.async {
            Task {
                guard let region = self.cameraPosition.region else { return }
                
                var results: [ComicBookStore] = []
                
                let request = MKLocalSearch.Request()
                request.naturalLanguageQuery = "Comic Book Store"
                request.region = region
                
                let search = MKLocalSearch(request: request)
                
                if let response = try? await search.start() {
                    for item in response.mapItems {
                        results.append(
                            ComicBookStore(
                                name: item.name ?? "",
                                coordinate: item.placemark.coordinate
                            )
                        )
                    }
                }
                
                self.comicBookStores = results
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
        cameraPosition = .region(region)
        fetchNearbyStores()
        locationManager.stopUpdatingLocation()
    }
}
