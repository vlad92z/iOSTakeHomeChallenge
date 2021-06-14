//
//  CharactersViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by James Malcolm on 09/03/2021.
//

import Foundation
import UIKit
import os.log

struct Character: Codable {
    let url: String
    let name: String
    let gender: String
    let culture: String
    let born: String
    let died: String
    let aliases:  [String]
    let father: String
    let mother: String
    let spouse: String
    let allegiances: [String]
    let books: [String]
    let povBooks: [String]
    let tvSeries: [String]
    let playedBy: [String]
    
    /// Returns a formatted string,for which seasons the character appeared in, e.g. "I-V, VII-VIII"
    var seriesString: String {
        var seriesIntegers = [Int]()
        for series in tvSeries {
            guard let seasonNumber = Int(series.replacingOccurrences(of: "Season ", with: "")) else {
                os_log(.error, "Unexpected season format: %@", series)
                continue
            }
            seriesIntegers.append(seasonNumber)
        }
        return Int.romanNumeralRangeString(for: seriesIntegers)
    }
}

class CharactersViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var cachedCharacters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCharacters()
    }
    
    func getCharacters() {
        var request = URLRequest(url: URL(string: "https://anapioficeandfire.com/api/characters")!)
        request.httpMethod = "GET"
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        config.httpAdditionalHeaders = [
            "Content-Type": "application/json"
        ]
        let task = URLSession(configuration: config).dataTask(with: request, completionHandler: { (data, response, error) in
            if let networkError = error {
                os_log(.error, "Character network task failed with error: \(networkError.localizedDescription)")
            }
            
            guard let data = data else {
                os_log(.error, "Character network request returned no data")
                return
            }
            
            do {
                let characters = try JSONDecoder().decode([Character].self, from: data)
                DispatchQueue.main.async {
                    self.loadData(characters: characters)
                }
            } catch {
                os_log(.error, "Failed to decode characters with error: \(error.localizedDescription)")
            }
        })
        task.resume()
    }
    
    /// Loads provided Characters in the table. Must be called on the main queue.
    /// - Parameter books: character objects to load
    func loadData(characters: [Character]) {
        cachedCharacters = characters
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cachedCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as! CharacterTableViewCell
        cell.setupWith(character: cachedCharacters[indexPath.row])
        return cell
    }
}

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cultureLabel: UILabel!
    @IBOutlet weak var bornLabel: UILabel!
    @IBOutlet weak var diedLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    
    func setupWith(character: Character) {
        nameLabel.text = character.name
        cultureLabel.text = character.culture
        bornLabel.text = character.born
        diedLabel.text = character.died
        seasonLabel.text = character.seriesString
    }
}
