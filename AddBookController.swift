//
//  AddBookController.swift
//  FlatironLibrary
//
//  Created by William Brancato on 3/14/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class AddBookController: UIViewController {
    
    let myView = AddBookView()
    
    override func viewDidLoad() {
        self.buildView()
        self.navigationItem.title = "Add Book"
        self.view.backgroundColor = UIColor.green  
    }
    
    func buildView() {
        self.view.addSubview(self.myView)
        self.myView.translatesAutoresizingMaskIntoConstraints = false
        self.myView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        self.myView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.myView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.myView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
}
