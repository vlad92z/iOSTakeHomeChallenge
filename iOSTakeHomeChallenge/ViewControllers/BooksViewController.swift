//
//  BooksViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by James Malcolm on 09/03/2021.
//

struct Book: Codable {
    
    static let dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //2014-06-17T00:00:00
    
    let url: String
    let name: String
    let isbn: String
    let authors: [String]
    let numberOfPages: Int
    let publisher: String
    let country: String
    let mediaType: String
    let released: Date
    let characters: [String]
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter
    }
}

import Foundation
import UIKit
import os.log

class BooksViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cachedBooks: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBooks()
    }
    
    func getBooks() {
        var request = URLRequest(url: URL(string: "https://anapioficeandfire.com/api/books")!)
        request.httpMethod = "GET"
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        config.httpAdditionalHeaders = [
            "Content-Type": "application/json"
        ]
        let task = URLSession(configuration: config).dataTask(with: request, completionHandler: { (data, response, error) in
            if let networkError = error {
                os_log(.error, "Book network task failed with error: \(networkError.localizedDescription)")
            }
            
            guard let data = data else {
                os_log(.error, "Book network request returned no data")
                return
            }
            	
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(Book.dateFormatter)
                
                let books = try decoder.decode([Book].self, from: data).sorted { $0.released < $1.released }
                DispatchQueue.main.async {
                    self.loadData(books: books)
                }
            } catch {
                os_log(.error, "Failed to decode books with error: \(error.localizedDescription)")
            }
            
        })
        task.resume()
    }
    
    /// Loads provided books in the table. Must be called on the main queue.
    /// - Parameter books: book objects to load
    func loadData(books: [Book]) {
        cachedBooks = books
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cachedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BooksTableViewCell") as! BooksTableViewCell
        cell.setupWith(book: cachedBooks[indexPath.row])
        return cell
    }
    
}

class BooksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var pagesLabel: UILabel!
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM YYYY"
        return formatter
    }
    
    func setupWith(book: Book) {
        titleLabel.text = book.name
        dateLabel.text = dateFormatter.string(from: book.released)
        pagesLabel.text =  "\(String(book.numberOfPages)) pages"
    }
}
