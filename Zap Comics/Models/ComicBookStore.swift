//
//  ComicBookStore.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/19/24.
//

import SwiftUI
import MapKit
import CoreLocation

struct ComicBookStore: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
