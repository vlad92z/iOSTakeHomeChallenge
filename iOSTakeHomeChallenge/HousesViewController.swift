//
//  HousesViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by James Malcolm on 09/03/2021.
//

import Foundation
import UIKit
import os.log

struct House: Codable {
    let url: String
    let name: String
    let region: String
    let coatOfArms: String
    let words: String
    let titles: [String]
    let seats: [String]
    let currentLord: String
    let heir: String
    let overlord: String
    let founded: String
    let founder: String
    let diedOut: String
    let ancestralWeapons: [String]
    let cadetBranches: [String]
    let swornMembers: [String]
}

class HousesViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var cachedHouses: [House] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getHouses()
    }
    
    func getHouses() {
        var request = URLRequest(url: URL(string: "https://anapioficeandfire.com/api/houses")!)
        request.httpMethod = "GET"
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        config.httpAdditionalHeaders = [
            "Content-Type": "application/json"
        ]
        let task = URLSession(configuration: config).dataTask(with: request, completionHandler: { (data, response, error) in
            if let networkError = error {
                os_log(.error, "House network task failed with error: \(networkError.localizedDescription)")
            }
            
            guard let data = data else {
                os_log(.error, "House network request returned no data")
                return
            }
            
            do {
                let houses = try JSONDecoder().decode([House].self, from: data)
                DispatchQueue.main.async {
                    self.loadData(houses: houses)
                }
            } catch {
                os_log(.error, "Failed to decode books with error: \(error.localizedDescription)")
            }
        })
        task.resume()
    }
    
    /// Loads provided family houses in the table. Must be called on the main queue.
    /// - Parameter books: house objects to load
    func loadData(houses: [House]) {
        cachedHouses = houses
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cachedHouses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HouseTableViewCell") as! HouseTableViewCell
        cell.setupWith(house: cachedHouses[indexPath.row])
        return cell
    }
}

class HouseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var wordsLabel: UILabel!
    
    func setupWith(house: House) {
        nameLabel.text = house.name
        regionLabel.text = house.region
        wordsLabel.text =  house.words
    }
}
