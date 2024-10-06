//
//  WeeklyList.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation

class WeeklyList: Codable {
    
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

class WeeklyListResponse: Codable {
    var weeklyList: WeeklyList
    
    private enum CodingKeys: String, CodingKey {
        case weeklyList = "weekly_list"
    }
}

extension WeeklyListResponse {
    static var preview: WeeklyListResponse {
        let url = Bundle.main.url(forResource: "WeeklyList", withExtension: "json")!

        let data = try? Data(contentsOf: url)
        let responseObject: WeeklyListResponse? = try? JSONDecoder().decode(self, from: data!)
        return responseObject!
    }
}
