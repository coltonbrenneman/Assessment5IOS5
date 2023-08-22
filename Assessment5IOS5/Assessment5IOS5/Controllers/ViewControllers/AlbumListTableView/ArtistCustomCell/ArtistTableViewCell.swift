//
//  ArtistTableViewCell.swift
//  Assessment5IOS5
//
//  Created by Colton Brenneman on 6/25/23.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumSongCountLabel: UILabel!
    
    // MARK: - Properties
    var albumToSend: AlbumResult?
    var albumImageToSend: UIImage?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumImageView.image = nil
    }
    
    // MARK: - Functions
    func updateUI(album: AlbumResult) {
        albumToSend = album
        fetchImage(album: album)
    } // End of updateUI
    
    func fetchImage(album: AlbumResult) {
        guard let imagePath = album.imagePath else { return }
        NetworkingController().fetchImage(with: imagePath) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.albumImageToSend = image
                    self.albumImageView.image = image
                    self.albumNameLabel.text = album.albumName
                    self.albumSongCountLabel.text = "\(album.trackCount)"
                }
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    } // End of fetchImage
    
} // End of class
