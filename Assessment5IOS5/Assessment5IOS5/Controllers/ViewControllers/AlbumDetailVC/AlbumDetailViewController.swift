//
//  AlbumDetailViewController.swift
//  Assessment5IOS5
//
//  Created by Colton Brenneman on 6/25/23.
//

import UIKit

class AlbumDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var songResultsTableView: UITableView!
    @IBOutlet weak var albumImageView: UIImageView!

    // MARK: - Properties
    var albumImageSentViaSegue: UIImage?
    var albumSentViaSegue: [SongResult]? {
        didSet {
            updateUI()
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        songResultsTableView.dataSource = self
        songResultsTableView.reloadData()
    }
    
    // MARK: - Functions
    func updateUI() {
        guard let unWrappedSong = albumSentViaSegue,
              let unWrappedImage = albumImageSentViaSegue else { return }
        
        DispatchQueue.main.async {
            self.albumNameLabel.text = unWrappedSong.first?.collectionName
            self.albumImageView.image = unWrappedImage
        }
    } // End of updateUI
    
} // End of class

extension AlbumDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumSentViaSegue?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath)
        
        guard let song = albumSentViaSegue?[indexPath.row] else { return cell }
        let durationInSeconds = (song.songDuration ?? 0) / 1000 
        let minutes = durationInSeconds / 60
        let seconds = durationInSeconds % 60
        var config = cell.defaultContentConfiguration()
        config.text = song.songName
        config.secondaryText =  String(format: "%d:%02d", minutes, seconds)
        cell.contentConfiguration = config
        
        return cell
    }
}
