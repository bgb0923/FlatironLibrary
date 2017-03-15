//
//  BookStore.swift
//  FlatironLibrary
//
//  Created by William Brancato on 3/14/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation

class BookStore {
    
    static let highlander = BookStore()
    
    var books = [Book]()
    
    private init() {
    }
    
    func fillArray(completion: @escaping () -> Void) {
        self.books.removeAll()
        APIClient.getBooks { (json) in
            json.forEach { self.books.append(Book(json: $0)) }
            completion()
        }
    }
}
