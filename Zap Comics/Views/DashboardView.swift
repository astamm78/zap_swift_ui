//
//  DashboardView.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View {
        VStack {
            Text("Dashboard")
            
            Text("Welcome " + (viewModel.currentUser?.username ?? ""))
            
            Button(
                "Log Out"
            ) {
                viewModel.logOut()
            }
        }
    }
}

#Preview {
    DashboardView()
        .environmentObject(ContentViewModel())
}
