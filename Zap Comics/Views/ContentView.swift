//
//  ContentView.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View {
        if let _ = viewModel.currentUser {
            DashboardView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ContentViewModel())
}
