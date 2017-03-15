//
//  APIClient.swift
//  FlatironLibrary
//
//  Created by William Brancato on 3/14/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation

class APIClient {
    
    static private let baseURL = "https://flatironchallenge.herokuapp.com"
    
    class func getBooks(completion: @escaping ([[String:Any]]) -> Void) {
        guard let url = URL(string: "\(self.baseURL)/books") else { return }
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] ?? [[:]]
                        completion(json)
                    } catch {
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    class func getCover(url: URL, completion: @escaping (Data) -> Void) {
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async { // this works here because the completion handlers connect everything
                if let data = data {
                    completion(data)
                }
            }
        }
        dataTask.resume()
    }
    
    class func checkOut(id: Int) {
        print(id)
        let urlString = "\(self.baseURL)/books/\(id)"
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "PUT"
        let dictionary = ["lastcheckedoutby": "BillyB"]
        if let json = try? JSONSerialization.data(withJSONObject: dictionary, options: []) {
            urlRequest.httpBody = json
            let session = URLSession.shared
            let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
                if let response = response as? HTTPURLResponse {
                    print(response.statusCode)
                }
            }
            dataTask.resume()
        }
    }
    
    class func addBook(title: String, author: String, publisher: String) {
        let urlString = "\(self.baseURL)/books/"
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        print(urlRequest)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        let dictionary = ["title": title,
                          "author": author,
                          "publisher": publisher,
                          "url": "www.thisisafakeurl.com"]
        if let json = try? JSONSerialization.data(withJSONObject: dictionary, options: []) {
            urlRequest.httpBody = json
            let session = URLSession.shared
            let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
                if let response = response as? HTTPURLResponse {
                    print(response.statusCode)
                }
            }
            dataTask.resume()
        }
    }
    
    
    class func deleteBook(id: Int) {
        let urlString = "\(self.baseURL)/books/\(id)"
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
        }
        dataTask.resume()
    }
}

