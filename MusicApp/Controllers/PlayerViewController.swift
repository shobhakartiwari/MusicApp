//
//  PlayerViewController.swift
//  MusicApp
//
//  Created by  ST on 3/30/23.
//

import UIKit
import AVFoundation
class PlayerViewController: UIViewController {
    var song: Song?
    var playerViewModel: PlayerViewModel!
    var timeObserverToken: Any?
    
    @IBOutlet weak var songThumbnail: UIImageView!
    @IBOutlet weak var songArtistLabel: UILabel!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var slider: UISlider!
    
    init(song: Song? = nil) {
      
        self.song = song
        super.init(nibName: nil, bundle: nil)
    }
    
   
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songTitleLabel.text = playerViewModel.song.trackName
        songArtistLabel.text = playerViewModel.song.artistName
       
        if let cachedImage = playerViewModel.cachedImage {
                   songThumbnail.image = cachedImage
        } else {
            songThumbnail.image = UIImage(named: "DefaultMusicIcon")
        }
        
        playerViewModel.play()
        slider.maximumValue = Float(30.00)
        observePlayerTime()
    }
    
    @IBAction func playPauseButtonTapped(_ sender: Any) {
        if playerViewModel.isPlaying == true{
                    playerViewModel.pause()
                    playPauseButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        } else {
                    playerViewModel.play()
                    playPauseButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
                }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let time = CMTime(seconds: Double(sender.value), preferredTimescale: 1000)
              playerViewModel.seek(to: time)
    }
 
    private func stopUpdatingSlider() {
        playerViewModel.pause()
        // Remove the time observer when it is no longer needed
        if let token = timeObserverToken {
            playerViewModel.player?.removeTimeObserver(token)
            timeObserverToken = nil
        }
    }
    
    func updateSlider(value: Float) {
           slider.setValue(value, animated: true)
       }
       
       func observePlayerTime() {
           let interval = CMTimeMakeWithSeconds(0.1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
           
           timeObserverToken = playerViewModel.player?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
               let timeElapsed = CMTimeGetSeconds(time)
               self?.updateSlider(value: Float(timeElapsed))
              // self?.updateSliderValue()
           }
       }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


//func updateSliderValue() {
//    let currentTime = playerViewModel.getCurrentTime()?.seconds ?? 0
//    slider.value = Float(currentTime)
//    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//        self.updateSliderValue()
//    }
//}
