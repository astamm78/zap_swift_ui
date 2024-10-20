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
                let userResponse = try await SessionsNetwork.login(
                    with: self.loginName,
                    and: self.loginPassword
                )
                
                userResponse.user.save()
                self.currentUser = userResponse.user
                await Application.bootstrap()
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    func logOut() {
        User.clearCurrent()
        WeeklyList.clearCurrent()
        
        loginName = ""
        loginPassword = ""
        currentUser = nil
    }
    
    func register() {
        Task {
            do {
                let userResponse = try await SessionsNetwork.register(
                    with: self.loginName,
                    and: self.loginPassword
                )
                
                userResponse.user.save()
                self.currentUser = userResponse.user
                await Application.bootstrap()
            } catch {
                print(String(describing: error))
            }
        }
    }
    
}
