//
//  CharacterTableViewCell.swift
//  iOSTakeHomeChallenge
//
//  Created by Vlad on 14/06/2021.
//

import Foundation
import UIKit

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
