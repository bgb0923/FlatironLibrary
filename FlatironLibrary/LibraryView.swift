//
//  LibraryView.swift
//  FlatironLibrary
//
//  Created by William Brancato on 3/14/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class LibraryView: UIView, UITableViewDelegate, UITableViewDataSource, VisibleRowsProtocol {
    
    var tableView: UITableView!
    var visibleRows: [Int] {
        var visibleCells: [Int] = []
        if let visibleRows = self.tableView.indexPathsForVisibleRows {
            visibleRows.forEach {
                visibleCells.append($0.row)
            }
        }
        return visibleCells
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildTableView() {
        self.tableView = UITableView()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(LibraryViewCell.self, forCellReuseIdentifier: "BookCell")
        self.tableView.backgroundColor = UIColor.clear
        
        self.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookStore.highlander.books.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = BookStore.highlander.books[indexPath.row]
        let colorTouchNotification = Notification(name: Notification.Name("CheckOut"), object: book, userInfo: nil)
        NotificationCenter.default.post(colorTouchNotification)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! LibraryViewCell
        if cell.delegate == nil { cell.delegate = self }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let currentCell = cell as! LibraryViewCell
        currentCell.book = BookStore.highlander.books[indexPath.row]
        currentCell.indexPath = indexPath.row

    }
    
    
    
}
