//
//  RegistrationView.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    
    @State var showPrivacyPolicy: Bool = false
    
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
                        accessibilityIdentifier: TestingIdentifiers.RegistrationView.registerUsernameTextField
                    )
                    
                    ZapTextField(
                        placeholder: "Password",
                        text: $viewModel.loginPassword,
                        accessibilityIdentifier: TestingIdentifiers.RegistrationView.registerPasswordTextField
                    )
                    .isSecure()
                    
                    ZapButton(
                        action: {
                        viewModel.register()
                    },
                        label: "Sign Up"
                    )
                    .accessibilityIdentifier(TestingIdentifiers.RegistrationView.registerButton)
                    
                    Button("Privacy Policy") {
                        showPrivacyPolicy.toggle()
                    }
                    .foregroundStyle(.zapBlue)
                    
                }
                .padding()
                .fullScreenCover(isPresented: $showPrivacyPolicy) {
                    ZStack {
                        VStack(spacing: 20) {
                            HStack {
                                Button {
                                    showPrivacyPolicy.toggle()
                                } label: {
                                    Image(systemName: "chevron.down")
                                        .foregroundStyle(.zapBlue)
                                }

                                Spacer()
                            }
                            
                            WebView(url: URL(string: "https://zap-list.com/privacy")!)
                        }
                        .padding(20)
                    }
                }
            }
        }
    }
}

#Preview {
    RegistrationView()
        .environmentObject(ContentViewModel())
}
