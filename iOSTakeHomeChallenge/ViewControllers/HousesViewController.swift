//
//  HousesViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by James Malcolm on 09/03/2021.
//

import Foundation
import UIKit
import os.log

class HousesViewController: UITableViewController, SearchTermContaining {
    
    // used for object provider pagination
    var currentPage = 1
    var isLoading = false
    var cachedHouses: [House] = []
    var filteredHouses: [House] = []
    
    var searchTerm: String? {
        didSet {
            applySnapshot()
        }
    }
    
    var houseProvider = HouseProvider()
    
    private lazy var dataSource = makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        updateHouses()
    }
    
    /// Requests the next page of houses
    func updateHouses() {
        houseProvider.fetchData(for: currentPage) { houses, _ in
            // In case an error occurs every time a given page is requested, we will increment regardless of success/error
            self.currentPage += 1
            guard let houses = houses else {
                self.isLoading = false
                return
            }
            self.append(new: houses)
            
        }
    }
    
    /// Appends new data to the existing list of houses
    /// - Parameter houses: House objects to append
    func append(new houses: [House]) {
        cachedHouses.append(contentsOf: houses.filter({ house in
            house.name != ""
        }))
        applySnapshot()
    }
    
    /// Used to automatically fetch more data, when the end of the tableview is reached
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (offsetY > contentHeight - scrollView.frame.height) && !isLoading {
            isLoading = true
            updateHouses()
        }
    }
}

// MARK: UITableViewDiffableDataSource
private extension HousesViewController {
    
    enum Section {
        case houses
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, House>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, House>
    
    func makeDataSource() -> DataSource {
        return DataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, house in
                let cell = tableView.dequeueReusableCell(withIdentifier: "HouseTableViewCell") as! HouseTableViewCell
                cell.setupWith(house: house)
                return cell
            }
        )
    }
    
    func applySnapshot(animated: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.houses])
        
        if let searchTerm = searchTerm?.lowercased(), !searchTerm.isEmpty {
            let filtered = cachedHouses.filter { character in
                character.name.lowercased().contains(searchTerm)
            }
            snapshot.appendItems(filtered)
        } else {
            snapshot.appendItems(cachedHouses)
        }
        dataSource.apply(snapshot, animatingDifferences: animated) {
            self.isLoading = false
        }
    }
}

