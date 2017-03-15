//
//  LibraryViewCell.swift
//  FlatironLibrary
//
//  Created by William Brancato on 3/14/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class LibraryViewCell: UITableViewCell {
    
    var bookImage = UIImageView()
    var titleLabel = UILabel()
    var authorLabel = UILabel()
    var indexPath: Int!
    
    var book: Book! {
        didSet {
            self.setBookImage()
            self.buildLabels()
        }
    }
    
    weak var delegate: VisibleRowsProtocol!
    
    func setBookImage() {
        self.addSubview(self.bookImage)
        self.bookImage.translatesAutoresizingMaskIntoConstraints = false
        self.bookImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        self.bookImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        self.bookImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        self.bookImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        self.bookImage.backgroundColor = UIColor.black
        self.book.setCover { _ in
            if self.delegate.visibleRows.contains(self.indexPath) {
                self.bookImage.image = self.book.cover
            }
        }
    }
    
    func buildLabels() {
        self.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.topAnchor.constraint(equalTo: self.bookImage.topAnchor).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.bookImage.trailingAnchor, constant: 20).isActive = true
        self.titleLabel.heightAnchor.constraint(equalTo: self.bookImage.heightAnchor, multiplier: 0.45).isActive = true
        self.titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.65).isActive = true
        self.titleLabel.text = self.book.title
        self.titleLabel.lineBreakMode = .byWordWrapping
        self.titleLabel.numberOfLines = 0
        
        self.addSubview(self.authorLabel)
        self.authorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.authorLabel.bottomAnchor.constraint(equalTo: self.bookImage.bottomAnchor).isActive = true
        self.authorLabel.leadingAnchor.constraint(equalTo: self.bookImage.trailingAnchor, constant: 20).isActive = true
        self.authorLabel.heightAnchor.constraint(equalTo: self.bookImage.heightAnchor, multiplier: 0.45).isActive = true
        self.authorLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.65).isActive = true
        self.authorLabel.text = "By: \(self.book.author)"
        self.authorLabel.lineBreakMode = .byWordWrapping
        self.authorLabel.numberOfLines = 0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.bookImage.image = nil
        self.titleLabel.text = nil
        self.authorLabel.text = nil
    }
}
