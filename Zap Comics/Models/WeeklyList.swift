//
//  WeeklyList.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation

class WeeklyList: Codable, Previewable, ObservableObject {

    typealias PreviewType = WeeklyList

    let dateFormatter = DateFormatter()
    
    var id: Int
    var dateString: String
    @Published var publishers: [Publisher]
    
    var date: Date? {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case dateString = "week"
        case publishers
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        dateString = try container.decode(String.self, forKey: .dateString)
        publishers = try container.decode([Publisher].self, forKey: .publishers)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(dateString, forKey: .dateString)
        try container.encode(publishers, forKey: .publishers)
    }
    
    func updateComicBookSelected(_ comicBook: ComicBook) {
        for publisher in publishers {
            publisher.updateComicBookSelected(comicBook)
        }
    }
    
    func updateComicBookPurchased(_ comicBook: ComicBook) {
        for publisher in publishers {
            publisher.updateComicBookPurchased(comicBook)
        }
    }
    
}

struct WeeklyListResponse: Codable, Previewable {
    typealias PreviewType = WeeklyListResponse

    var weeklyList: WeeklyList
    
    private enum CodingKeys: String, CodingKey {
        case weeklyList = "weekly_list"
    }
}
