//
//  BookTableViewCell.swift
//  iOSTakeHomeChallenge
//
//  Created by Vlad on 14/06/2021.
//

import Foundation
import UIKit

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
