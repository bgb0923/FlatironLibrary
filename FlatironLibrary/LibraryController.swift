//
//  ViewController.swift
//  FlatironLibrary
//
//  Created by William Brancato on 3/14/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import UIKit

class LibraryController: UIViewController {
    
    let library = LibraryView()
    var addBookButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue
        self.buildLibrary()
        self.buildNavigationBar()
        BookStore.highlander.fillArray() {
        self.library.tableView.reloadData() // I don't need DispatchQueue.main.async here because I have it in the API Call
        }
        NotificationCenter.default.addObserver(self, selector: #selector(goToCheckOutView),
                                               name: Notification.Name("CheckOut"),
                                               object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    func buildNavigationBar() {
        self.navigationItem.title = "Library"
        addBookButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addBook))
        navigationItem.rightBarButtonItem = addBookButton
    }
    
    func buildLibrary() {
        self.view.addSubview(self.library)
        self.library.translatesAutoresizingMaskIntoConstraints = false
        self.library.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.library.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.library.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.library.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    func goToCheckOutView(notification: Notification) {
        let bookDetailController = BookDetailController()
        if let book = notification.object as? Book {
            bookDetailController.myView.book = book
        }
        self.navigationController?.pushViewController(bookDetailController, animated: true)
    }
    
    // this function should not be in the view
    func addBook() {
        let addBookController = AddBookController()
        self.navigationController?.pushViewController(addBookController, animated: true)
    }
    
}

