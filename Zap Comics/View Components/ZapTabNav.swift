//
//  ZapTabNav.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import SwiftUI

struct ZapTabNav: View {
    var dashboardTab: DashboardView.DashboardTab
    
    var body: some View {
        NavigationView{
            dashboardTab.tabView
                .navigationBarTitle(dashboardTab.displayName, displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image(systemName: "star.fill")
                    }
                }
                .navigationBarItems(
                    leading: Button("Left") {},
                    trailing: Button("Right") {}
                )
            
        }
        .tabItem {
            VStack{
                Image(dashboardTab.iconName, bundle: nil)
                    .renderingMode(.template)
                Text(dashboardTab.displayName)
            }
        }
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarBackground(Color.zapYellow, for: .tabBar)
    }
}

#Preview {
    ZapTabNav(dashboardTab: .newComics)
}
