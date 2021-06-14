//
//  BooksViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by James Malcolm on 09/03/2021.
//

import Foundation
import UIKit
import os.log

class BooksViewController: UITableViewController, SearchTermContaining {
    
    // used for object provider pagination
    var currentPage = 1
    var isLoading = false
    var reachedEnd = false
    var cachedBooks: [Book] = []
    var filteredBooks: [Book] = []
    
    var searchTerm: String? {
        didSet {
            applySnapshot()
        }
    }
    
    var bookProvider = BookProvider()
    
    private lazy var dataSource = makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        updateBooks()
    }
    
    /// Requests the next page of books
    func updateBooks() {
        bookProvider.fetchData(for: currentPage) { books, _ in
            // In case an error occurs every time a given page is requested, we will increment regardless of success/error
            self.currentPage += 1
            guard let books = books else {
                self.isLoading = false
                return
            }
            if !books.isEmpty {
                self.append(new: books)
            } else {
                self.reachedEnd = true
            }
        }
    }
    
    /// Appends new data to the existing list of books
    /// - Parameter characters: Book objects to append
    func append(new books: [Book]) {
        cachedBooks.append(contentsOf: books.filter({ book in
            book.name != ""
        }))
        applySnapshot()
    }
    
    /// Used to automatically fetch more data, when the end of the tableview is reached
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !reachedEnd else {
            return
        }
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (offsetY > contentHeight - scrollView.frame.height) && !isLoading {
            isLoading = true
            updateBooks()
        }
    }
    
}

// MARK: UITableViewDiffableDataSource
private extension BooksViewController {
    
    enum Section {
        case books
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Book>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Book>
    
    func makeDataSource() -> DataSource {
        return DataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, book in
                let cell = tableView.dequeueReusableCell(withIdentifier: "BooksTableViewCell") as! BooksTableViewCell
                cell.setupWith(book: book)
                return cell
            }
        )
    }
    
    func applySnapshot(animated: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.books])
        
        if let searchTerm = searchTerm?.lowercased(), !searchTerm.isEmpty {
            let filtered = cachedBooks.filter { book in
                book.name.lowercased().contains(searchTerm)
            }
            snapshot.appendItems(filtered)
        } else {
            snapshot.appendItems(cachedBooks)
        }
        dataSource.apply(snapshot, animatingDifferences: animated) {
            self.isLoading = false
        }
    }
}
