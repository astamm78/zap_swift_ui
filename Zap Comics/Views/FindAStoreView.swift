//
//  FindAStoreView.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import SwiftUI
import MapKit

struct FindAStoreView: View {
    @EnvironmentObject var viewModel: MapViewModel
    
    @State private var showAlert = false
    
    var body: some View {
        Map(position: $viewModel.cameraPosition) {
            ForEach(viewModel.comicBookStores) { comicBookStore in
                Marker(
                    comicBookStore.name,
                    coordinate: comicBookStore.coordinate
                )
            }
        }
    }
}

#Preview {
    FindAStoreView()
        .environmentObject(MapViewModel.shared)
}
