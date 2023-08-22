//
//  AlbumDetailViewController.swift
//  Assessment5IOS5
//
//  Created by Colton Brenneman on 6/25/23.
//

import UIKit

class AlbumDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var songResultsTableView: UITableView!
    
    // MARK: - Properties
    var albumSent: TopLevelSongDictionary?
    var albumImageSent: UIImage?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
} // End of class

extension AlbumDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumSent?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath)
        
        let songs = albumSent?.results[indexPath.row]
        var config = cell.defaultContentConfiguration()
        config.text = songs?.songName
        config.secondaryText = "\(songs?.songDuration ?? 0)"
        cell.contentConfiguration = config
        
        return cell
    }
}
