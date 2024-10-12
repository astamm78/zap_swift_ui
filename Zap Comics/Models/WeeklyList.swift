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
    
    func updateComicBook(_ addedComicBook: ComicBook) -> Self {
        var mutable = self

        for publisher in mutable.publishers {
            for comicBook in publisher.comicBooks {
                if comicBook == addedComicBook {
                    comicBook.selected.toggle()
                    return mutable
                }
            }
        }

        return self
    }
    
}

class WeeklyListResponse: Codable, Previewable {
    typealias PreviewType = WeeklyListResponse

    var weeklyList: WeeklyList
    
    private enum CodingKeys: String, CodingKey {
        case weeklyList = "weekly_list"
    }
}
