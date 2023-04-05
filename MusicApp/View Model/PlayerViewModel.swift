//
//  PlayerViewModel.swift
//  MusicApp
//
//  Created by  ST on 3/30/23.
//

import Foundation
import AVFAudio
import AVFoundation
import UIKit

class PlayerViewModel {
    var song: Song
    var player: AVPlayer?
    var isPlaying = false
    var timeObserverToken: Any?
    
    var cachedImage: UIImage!
    
    
    init(song: Song) {
        self.song = song
    }

    func play(){
        if player == nil {
            guard let previewURL = URL(string: song.previewURL!) else {
                print("no valid preview url")
                return
            }
            let playerItem = AVPlayerItem(url: previewURL)
            self.player = AVPlayer(playerItem: playerItem)
        }
        player?.play()
        isPlaying = true
    }
    
    func pause() {
            player?.pause()
            isPlaying = false
        }
    
   
    func getDuration() -> CMTime? {
            return player?.currentItem?.duration
    }
    private var durationObserver: NSKeyValueObservation?

    func getDuration(completion: @escaping (CMTime?) -> Void) {
        durationObserver = player?.currentItem?.observe(\.duration, options: [.new, .initial]) { [weak self] (playerItem, _) in
            if playerItem.status == .readyToPlay {
                completion(playerItem.duration)
                self?.durationObserver = nil
            }
        }
    }

    func getCurrentTime() -> CMTime? {
            return player?.currentTime()
        }
    
    func seek(to time: CMTime) {
            player?.seek(to: time)
        player?.play()
        isPlaying = true
        }
    
}
