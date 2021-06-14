//
//  SearchViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by Vlad on 14/06/2021.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    
    var searchTarget: SearchTermContaining?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let searchTarget = segue.destination as? SearchTermContaining else {
            fatalError("Found unexpected destination in segue")
        }
        self.searchTarget = searchTarget
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTarget?.searchTerm = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
