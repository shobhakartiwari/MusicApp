//
//  CustomTableViewCell.swift
//  MusicApp
//
//  Created by  ST on 3/29/23.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var songThumbnail: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var songTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCellData(song: Song, cache: NSCache<NSURL, UIImage>){
        artistNameLabel.text = song.artistName
        songTitleLabel.text = song.trackName
        if let artworkURL = song.artworkUrl100, let url = URL(string: artworkURL) {
            songThumbnail.setImage(from: url, cache: cache)
        } else {
           songThumbnail.image = UIImage(named: "DefaultMusicIcon")
        }
        //songThumbnail.setImage(from: URL(string: song.artworkUrl100!)!, cache: cache)
    }
}
