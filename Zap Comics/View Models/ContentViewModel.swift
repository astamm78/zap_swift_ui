//
//  ContentViewModel.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation

@MainActor
class ContentViewModel: ObservableObject {
    
    @Published var currentUser: User? = User.current
    @Published var loginName: String = ""
    @Published var loginPassword: String = ""
    
    func login() {
        Task {
            guard let userResponse = try? await SessionsNetwork.login(
                with: self.loginName,
                and: self.loginPassword
            ) else {
                return
            }
            
            userResponse.user.save()
            self.currentUser = userResponse.user
        }
    }
    
    func logOut() {
        UserDefaults.standard.removeObject(forKey: User.curentUserKey)
        
        loginName = ""
        loginPassword = ""
        currentUser = nil
    }
    
    func register() {
        Task {
            guard let userResponse = try? await SessionsNetwork.register(
                with: self.loginName,
                and: self.loginPassword
            ) else {
                return
            }
            
            userResponse.user.save()
            self.currentUser = userResponse.user
        }
    }
    
}
