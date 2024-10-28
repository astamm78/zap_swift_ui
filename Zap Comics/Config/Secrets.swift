//
//  Secrets.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/28/24.
//

import Foundation

struct Secrets {
    
    static var dictionary: NSDictionary? {
        guard let plistPath = Bundle.main.path(forResource: "Secrets", ofType: "plist") else {
            return nil
        }
        
        return NSDictionary(contentsOfFile: plistPath)
    }
    
    static var apiKey: String? {
        dictionary?["apiKey"] as? String
    }
    
    static var userPreviewUsername: String? {
        dictionary?["userPreviewUsername"] as? String
    }
    
    static var userPreviewApiKey: String? {
        dictionary?["userPreviewApiKey"] as? String
    }
}
