//
//  AlbumListTableViewController.swift
//  Assessment5IOS5
//
//  Created by Colton Brenneman on 8/21/23.
//

import UIKit

class AlbumListTableViewController: UITableViewController {

    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    var topLevelDictionary: TopLevelAlbumDictionary?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topLevelDictionary?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as? ArtistTableViewCell else { return UITableViewCell() }

        guard let albums = topLevelDictionary else { return UITableViewCell() }
        let albumDict = albums.results[indexPath.row]
        cell.updateUI(album: albumDict)
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toDetailVC",
              let indexPath = tableView.indexPathForSelectedRow,
              let cell = tableView.cellForRow(at: indexPath) as? ArtistTableViewCell,
              let destination = segue.destination as? AlbumDetailViewController else { return }
        guard let album = cell.albumToSend else { return }
        let albumImage = cell.albumImageToSend
        
        NetworkingController().fetchSong(with: album.albumID) { result in
            switch result {
            case .success(let songDetailDict):
                destination.albumImageSentViaSegue = albumImage
                destination.albumSentViaSegue = songDetailDict
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
} // End of class

// MARK: - Extension
extension AlbumListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        NetworkingController().fetchAritst(with: searchTerm) { result in
            switch result {
            case .success(let tld):
                DispatchQueue.main.async {
                    self.topLevelDictionary = tld
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.errorDescription)
            }
        }
        searchBar.resignFirstResponder()
    }
}
