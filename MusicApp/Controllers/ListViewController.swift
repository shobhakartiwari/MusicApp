//
//  ViewController.swift
//  MusicApp
//
//  Created by  ST on 3/29/23.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
   
    var viewModel: ViewModel = ViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        
        viewModel.getSongData(artistName: "Red Hot Chilli Pepper"){
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ListViewController {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell else {
            fatalError("Error setting up resuable cell")
        }

        let song: Song = (viewModel.songResult[indexPath.row])
        cell.setCellData(song: song, cache: viewModel.imageCache)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumOfRows()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  let song = viewModel.songResult![indexPath.row]
        let song = viewModel.songResult[indexPath.row]
        let cachedImage = viewModel.imageCache.object(forKey: URL(string: song.artworkUrl100!)! as NSURL)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let playerVC = storyboard.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        let playerVM = PlayerViewModel(song: song)
        playerVC.playerViewModel = playerVM
        playerVC.playerViewModel.cachedImage = cachedImage

        self.present(playerVC, animated: true, completion: nil)
    }
    
}
