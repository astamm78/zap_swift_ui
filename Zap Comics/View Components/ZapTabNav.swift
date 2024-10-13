//
//  ZapTabNav.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import SwiftUI

struct ZapTabNav: View {
    var dashboardTab: DashboardView.DashboardTab

    let coloredNavAppearance = UINavigationBarAppearance()

    init(dashboardTab: DashboardView.DashboardTab) {
        self.dashboardTab = dashboardTab

        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = .zapYellow
        coloredNavAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        coloredNavAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }

    var body: some View {
        NavigationView{
            dashboardTab.tabView
                .navigationBarTitle(dashboardTab.displayName, displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("zap-logo-small")
                            .accessibilityIdentifier(TestingIdentifiers.Dashboard.navLogoImage)
                    }
                }
                // .navigationBarItems(
                //     leading: Button("Left") {},
                //     trailing: Button("Right") {}
                // )

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
    let vm = DashboardViewModel()
    vm.dataLoaded = true

    return ZapTabNav(dashboardTab: .newComics)
        .environmentObject(vm)
}
