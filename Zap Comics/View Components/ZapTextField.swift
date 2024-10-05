//
//  ZapTextField.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import SwiftUI

class ZapTextFieldViewModel: ObservableObject {
    @Published var isPasswordField: Bool = false
}

struct ZapTextField: View {
    var placeholder: String
    
    @ObservedObject var viewModel = ZapTextFieldViewModel()
    
    @Binding var text: String
    
    var body: some View {
        VStack {
            if viewModel.isPasswordField {
                SecureField(
                    placeholder,
                    text: $text
                )
                .autocapitalization(.none)
            } else {
                TextField(
                    placeholder,
                    text: $text
                )
                .autocapitalization(.none)
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray, lineWidth: 3)
        )
        
    }
    
    func isSecure() -> Self {
        viewModel.isPasswordField = true
        return self
    }
}

#Preview {
    NavigationView {
        ZStack {
            Color.gray.opacity(0.4)
                .ignoresSafeArea()
            
            VStack {
                ZapTextField(
                    placeholder: "Username",
                    text: .constant("")
                )
            }
            .padding()
        }
    }
}
