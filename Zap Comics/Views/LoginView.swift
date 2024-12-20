//
//  LoginView.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View {
        NavigationView {
            ZapContainer {
                VStack(spacing: 18) {
                    ResizableImage(
                        name: "zap-logo",
                        height: 340,
                        width: UIScreen.main.bounds.width - 40,
                        contentMode: .fit
                    )
                    
                    ZapTextField(
                        placeholder: "Username",
                        text: $viewModel.loginName,
                        accessibilityIdentifier: TestingIdentifiers.LoginView.loginUsernameTextField
                    )

                    ZapTextField(
                        placeholder: "Password",
                        text: $viewModel.loginPassword,
                        accessibilityIdentifier: TestingIdentifiers.LoginView.loginPasswordTextField
                    )
                    .isSecure()

                    ZapButton(
                        action: {
                            viewModel.login()
                        },
                        label: "Login"
                    )
                    .accessibilityIdentifier(TestingIdentifiers.LoginView.loginButton)

                    NavigationLink(
                        "Register"
                    ) {
                        RegistrationView()
                    }
                    .accessibilityIdentifier(TestingIdentifiers.LoginView.registrationLink)
                    
                    NavigationLink(
                        "Find a Comic Store"
                    ) {
                        FindAStoreView()
                            .environmentObject(MapViewModel.shared)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(ContentViewModel())
}
