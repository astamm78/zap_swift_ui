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
    
    static var shared: ContentViewModel = ContentViewModel()
    
    func login() {
        Task {
            do {
                let userResponse = try await SessionsNetwork().login(
                    with: self.loginName,
                    and: self.loginPassword
                )
                
                loadForUser(userResponse.user)
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    func logOut() {
        if User.clearCurrent() {
            WeeklyList.clearCurrent()
            
            loginName = ""
            loginPassword = ""
            currentUser = nil
        }
    }
    
    func deleteAccount() {
        Task {
            do {
                let success = try await SessionsNetwork().deleteAccount()
                
                guard success else { return }
                
                logOut()
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    func register() {
        Task {
            do {
                let userResponse = try await SessionsNetwork().register(
                    with: self.loginName,
                    and: self.loginPassword
                )
                
                loadForUser(userResponse.user)
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    fileprivate func loadForUser(_ user: User) {
        user.save { success in
            if success {
                if let _currentUser = User.current {
                    print("User data saved")
                    Task {
                        await Application.bootstrap()
                        self.currentUser = _currentUser
                    }
                } else {
                    print("Failed to retrieve user")
                }
            } else {
                print("Failed to save user")
            }
        }
    }
    
}
