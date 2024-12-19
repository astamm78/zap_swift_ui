//
//  Application.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/20/24.
//

import Foundation

protocol ApplicationManager {
    static func bootstrap() async -> Void
}

class Application: ApplicationManager {
    
    fileprivate static let current = Application()

    @MainActor static func bootstrap() async {
        guard let _ = User.current?.apiKey else {
            return
        }
        
        DashboardViewModel.shared.loadInitialData()
    }
    
}

let App = Application.current
