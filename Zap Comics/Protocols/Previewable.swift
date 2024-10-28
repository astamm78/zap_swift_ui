//
//  Previewable.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/11/24.
//

import Foundation

protocol Previewable {
    associatedtype PreviewType: Decodable
    static var preview: PreviewType { get }
}

extension Previewable {
    static var preview: PreviewType {
        return loadPreview(from: String(describing: PreviewType.self))
    }

    static func customPreview(from filename: String) -> PreviewType {
        return loadPreview(from: filename)
    }

    private static func loadPreview(from filename: String) -> PreviewType {
        let url = Bundle.main.url(forResource: filename, withExtension: "json")!
        let data = try! Data(contentsOf: url)
        
        var jsonDict = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        
        if jsonDict["username"] as? String == "REMOVED_KEY" {
            jsonDict["username"] = Secrets.userPreviewUsername ?? ""
        }
        
        if jsonDict["api_key"] as? String == "REMOVED_KEY" {
            jsonDict["api_key"] = Secrets.userPreviewApiKey ?? ""
        }
        
        let updatedData = try! JSONSerialization.data(withJSONObject: jsonDict, options: [])

        return try! JSONDecoder().decode(PreviewType.self, from: updatedData)
    }
}
