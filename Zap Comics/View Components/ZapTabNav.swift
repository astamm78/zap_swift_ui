//
//  ZapTabNav.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import SwiftUI

struct ZapTabNav: View {
    @EnvironmentObject var contentVM: ContentViewModel

    var dashboardTab: DashboardTab

    let coloredNavAppearance = UINavigationBarAppearance()

    init(dashboardTab: DashboardTab) {
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
                .navigationBarItems(
                    leading: Menu(content: {
                        Button {
                            contentVM.logOut()
                        } label: {
                            Text("Sign Out")
                        }
                        .accessibilityIdentifier(TestingIdentifiers.Dashboard.logoutButton)
                    }, label: {
                        Image(systemName: "line.horizontal.3")
                            .fontWeight(.bold)
                            .accessibilityIdentifier(TestingIdentifiers.Dashboard.menuButton)
                    })

                )
        }
        .tabItem {
            VStack{
                Image(dashboardTab.iconName, bundle: nil)
                    .renderingMode(.template)
                Text(dashboardTab.displayName)
            }
        }
        .accessibilityIdentifier(dashboardTab.testingIdentifier)
        .accessibilityAddTraits(.isSelected)
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarBackground(Color.zapYellow, for: .tabBar)
    }
}

#Preview {
    let vm = DashboardViewModel()

    return ZapTabNav(dashboardTab: .newComics)
        .environmentObject(vm)
        .environmentObject(ContentViewModel())
}
