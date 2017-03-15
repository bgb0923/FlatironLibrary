//
//  Book.swift
//  FlatironLibrary
//
//  Created by William Brancato on 3/14/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class Book {
    let author: String
    let id: Int
    let lastCheckedOut: String?
    let lastCheckedOutBy: String?
    let publisher: String
    let title: String
    var url: URL?
    var cover: UIImage?
    
    init(json: [String:Any]) {
        self.author = json["author"] as? String ?? "Unknown"
        self.id = json["id"] as? Int ?? 0
        self.lastCheckedOut = json["lastCheckedOut"] as? String
        self.lastCheckedOutBy = json["lastCheckedOutBy"] as? String
        self.publisher = json["publisher"] as? String ?? "No Publisher"
        self.title = json["title"] as? String ?? "Unknown"
        
        if var urlString = json["url"] as? String {
            urlString = urlString.replacingOccurrences(of: "http", with: "https")
            self.url = URL(string: urlString )
        }
    }
    
    func setCover(completion: @escaping () -> Void) {
        if let url = self.url {
            APIClient.getCover(url: url, completion: { (data) in
                self.cover = UIImage(data: data)
                completion()
            })
        }
    }
}

extension Book: CustomStringConvertible {
    
    var description: String { return "\(self.title)" }
    
}
