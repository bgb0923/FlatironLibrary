//
//  AddBookView.swift
//  FlatironLibrary
//
//  Created by William Brancato on 3/14/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class AddBookView: UIView {
    
    var titleField = UITextField()
    var publisherField = UITextField()
    var authorField = UITextField()
    var submitButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildView()
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView() {
        
        let viewArray: [UIView] = [self.titleField, self.authorField, self.publisherField, self.submitButton]
        
        viewArray.forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
        
        self.titleField.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        self.titleField.borderStyle = .roundedRect
        self.titleField.placeholder = "Enter Title Here"
        
        self.authorField.topAnchor.constraint(equalTo: self.titleField.bottomAnchor, constant: 20).isActive = true
        self.authorField.borderStyle = .roundedRect
        self.authorField.placeholder = "Enter Author Here"
        
        self.publisherField.topAnchor.constraint(equalTo: self.authorField.bottomAnchor, constant: 20).isActive = true
        self.publisherField.borderStyle = .roundedRect
        self.publisherField.placeholder = "Enter Publisher Here"
        
        self.submitButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20).isActive = true
        self.submitButton.setTitle("SUBMIT", for: .normal)
        self.submitButton.setTitleColor(UIColor.black, for: .normal)
        self.submitButton.layer.cornerRadius = 10
        self.submitButton.layer.borderColor = UIColor.black.cgColor
        self.submitButton.layer.borderWidth = 3
        self.submitButton.addTarget(self, action: #selector(self.submit), for: .touchUpInside)
    }
    
    func submit() {
        guard let title = self.titleField.text
            , let author = self.authorField.text
            , let publisher = self.publisherField.text else { return }
        
        APIClient.addBook(title: title, author: author, publisher: publisher)
    }
    
}
