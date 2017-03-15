//
//  CheckOutView.swift
//  FlatironLibrary
//
//  Created by William Brancato on 3/14/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class CheckOutView: UIView {
    
    var book: Book! {
        didSet {
            self.buildView()
        }
    }
    
    var imageView = UIImageView()
    var titleLabel = UILabel()
    var lastCheckedOutLabel = UILabel()
    var publisherLabel = UILabel()
    var authorLabel = UILabel()
    
    var checkoutButton = UIButton()
    var deleteButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // this class and function does way to much, every item should be its own class with the below in the initializer
    func buildView() {
        
        let viewArray: [UIView] = [self.deleteButton, self.checkoutButton, self.lastCheckedOutLabel, self.publisherLabel, self.authorLabel, self.titleLabel]
        
        viewArray.forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
        self.deleteButton.setTitle("THIS BOOK SUCKED, DELETE IT", for: .normal)
        self.deleteButton.setTitleColor(UIColor.black, for: .normal)
        self.deleteButton.layer.cornerRadius = 10
        self.deleteButton.translatesAutoresizingMaskIntoConstraints = false
        self.deleteButton.layer.borderColor = UIColor.black.cgColor
        self.deleteButton.layer.borderWidth = 3
        self.deleteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        self.deleteButton.addTarget(self, action: #selector(self.deleteBook), for: .touchUpInside)
        
        self.checkoutButton.setTitle("CHECKOUT", for: .normal)
        self.checkoutButton.setTitleColor(UIColor.black, for: .normal)
        self.checkoutButton.layer.cornerRadius = 10
        self.checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        self.checkoutButton.layer.borderColor = UIColor.black.cgColor
        self.checkoutButton.layer.borderWidth = 3
        self.checkoutButton.bottomAnchor.constraint(equalTo: self.deleteButton.topAnchor, constant: -20).isActive = true
        self.checkoutButton.addTarget(self, action: #selector(self.checkoutBook), for: .touchUpInside)
        
        self.lastCheckedOutLabel.translatesAutoresizingMaskIntoConstraints = false
        self.lastCheckedOutLabel.bottomAnchor.constraint(equalTo: self.checkoutButton.topAnchor, constant: -20).isActive = true
        self.lastCheckedOutLabel.lineBreakMode = .byWordWrapping
        self.lastCheckedOutLabel.numberOfLines = 0
        self.lastCheckedOutLabel.textAlignment = .center
        
        if let checkedOutBy = self.book.lastCheckedOutBy, let checkedOutWhen = self.book.lastCheckedOut {
            self.lastCheckedOutLabel.text = "Last checked out by \(checkedOutBy) on \(checkedOutWhen)"
        } else {
            self.lastCheckedOutLabel.text = "Click below and be the first to check it out!"
        }
    
        self.publisherLabel.bottomAnchor.constraint(equalTo: self.lastCheckedOutLabel.topAnchor, constant: -20).isActive = true
        self.publisherLabel.text = "Published by: \(self.book.publisher)"
        self.publisherLabel.lineBreakMode = .byWordWrapping
        self.publisherLabel.numberOfLines = 0
        self.publisherLabel.textAlignment = .center
        
        self.authorLabel.bottomAnchor.constraint(equalTo: self.publisherLabel.topAnchor, constant: 20).isActive = true
        self.authorLabel.lineBreakMode = .byWordWrapping
        self.authorLabel.numberOfLines = 0
        self.authorLabel.text = "Written By: \(self.book.author)"
        self.authorLabel.textAlignment = .center
        
        self.titleLabel.bottomAnchor.constraint(equalTo: self.authorLabel.topAnchor, constant: 20).isActive = true
        self.titleLabel.lineBreakMode = .byWordWrapping
        self.titleLabel.numberOfLines = 0
        self.titleLabel.text = self.book.title
        self.titleLabel.textAlignment = .center
        
        self.addSubview(self.imageView)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: self.titleLabel.topAnchor, constant: -20).isActive = true
        self.imageView.backgroundColor = UIColor.black
        self.imageView.image = self.book.cover
    }
    
    // this function should technically be in the model
    func checkoutBook() {
        APIClient.checkOut(id: self.book.id)
    }
    
    // this function should technically be in the model
    func deleteBook() {
        print(self.book.id)
        APIClient.deleteBook(id: self.book.id)
    }
    
}
