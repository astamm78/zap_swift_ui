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
    
    @State private var showAlert = false

    init(dashboardTab: DashboardTab) {
        self.dashboardTab = dashboardTab

        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = .zapYellow
        coloredNavAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]

        coloredNavAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.black
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
                        User.current.map { currentUser in
                            Group {
                                Text("You've made \(currentUser.shoppingListCount ?? 0) lists.")
                                
                                Text("You've added \(currentUser.comicBooksCount ?? 0) comic books to your lists…")
                                
                                Text("…and purchased \(currentUser.purchasedComicBookCount ?? 0) of them!")
                            }
                        }
                        
                        Button {
                            contentVM.logOut()
                        } label: {
                            Text("Sign Out")
                        }
                        .accessibilityIdentifier(TestingIdentifiers.Dashboard.logoutButton)
                        
                        Button {
                            showAlert = true
                        } label: {
                            Text("Delete Your Account")
                        }
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
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Warning"),
                message: Text("This will delete your account and all saved data."),
                primaryButton: .destructive(
                    Text("Proceed"),
                    action: {
                        contentVM.deleteAccount()
                    }
                ),
                secondaryButton: .cancel()
            )
        }
    }
}

#Preview {
    let vm = DashboardViewModel()

    return ZapTabNav(dashboardTab: .newComics)
        .environmentObject(vm)
        .environmentObject(ContentViewModel())
}
