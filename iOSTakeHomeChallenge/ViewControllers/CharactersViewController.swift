//
//  CharactersViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by James Malcolm on 09/03/2021.
//

import Foundation
import UIKit
import os.log

class CharactersViewController: UITableViewController, SearchTermContaining {
    
    // used for object provider pagination
    var currentPage = 1
    var isLoading = false
    var cachedCharacters: [Character] = []
    var filteredCharacters: [Character] = []
    
    var searchTerm: String? {
        didSet {
            applySnapshot()
        }
    }
    
    var characterProvider = CharacterProvider()
    
    private lazy var dataSource = makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        updateCharacters()
    }
    
    /// Requests the next page of characters
    func updateCharacters() {
        characterProvider.fetchData(for: currentPage) { [weak self] characters, _ in
            // In case an error occurs every time a given page is requested, we will increment regardless of success/error
            self?.currentPage += 1
            guard let characters = characters else {
                self?.isLoading = false
                return
            }
            self?.append(new: characters)
            
        }
    }
    
    /// Appends new data to the existing list of characters
    /// - Parameter characters: Character objects to append
    func append(new characters: [Character]) {
        cachedCharacters.append(contentsOf: characters.filter({ character in
            character.name != ""
        }))
        applySnapshot()
    }
    
    /// Used to automatically fetch more data, when the end of the tableview is reached
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (offsetY > contentHeight - scrollView.frame.height) && !isLoading {
            isLoading = true
            updateCharacters()
        }
    }
}

// MARK: UITableViewDiffableDataSource
private extension CharactersViewController {
    
    enum Section {
        case characters
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Character>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Character>
    
    func makeDataSource() -> DataSource {
        return DataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, character in
                let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as! CharacterTableViewCell
                cell.setupWith(character: character)
                return cell
            }
        )
    }
    
    func applySnapshot(animated: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.characters])
        
        if let searchTerm = searchTerm?.lowercased(), !searchTerm.isEmpty {
            let filtered = cachedCharacters.filter { character in
                character.name.lowercased().contains(searchTerm)
            }
            snapshot.appendItems(filtered)
        } else {
            snapshot.appendItems(cachedCharacters)
        }
        dataSource.apply(snapshot, animatingDifferences: animated) {
            self.isLoading = false
        }
    }
}
