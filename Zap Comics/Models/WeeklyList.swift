//
//  WeeklyList.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation

class WeeklyList: Codable, Previewable {

    typealias PreviewType = WeeklyList

    let dateFormatter = DateFormatter()
    
    var id: Int
    var dateString: String
    var publishers: [Publisher]
    
    var date: Date? {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case dateString = "week"
        case publishers
    }
    
    func updateComicBook(_ addedComicBook: AddedComicBook) {
        guard let publisher = publishers.first(where: { $0.id == addedComicBook.publisher.id }),
              let comicBook = publisher.comicBooks.first(where: { $0.id == addedComicBook.id })  else {
            return
        }
        
        comicBook.selected.toggle()
    }
    
}

class WeeklyListResponse: Codable, Previewable {
    typealias PreviewType = WeeklyListResponse

    var weeklyList: WeeklyList
    
    private enum CodingKeys: String, CodingKey {
        case weeklyList = "weekly_list"
    }
}
