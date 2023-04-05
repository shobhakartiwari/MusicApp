//
//  ViewModel.swift
//  MusicApp
//
//  Created by  ST on 3/29/23.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case invalidURL(String)
    case notDataRecevied(String)
    case decodedFailed(String)
}

class ViewModel {
    var songResult: [Song] = []
    
    private func decode<T: Codable>(from data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    let imageCache = NSCache<NSURL, UIImage>()
    
    
    func getSongData(artistName: String, onCompletion: @escaping ()-> Void){
        print("get song data")
        APIHandler.shared.fetchAPI(url: API.searchURL(for: artistName)!){result in
            
            switch result {
            case .success(let data):
                do {
                    let parsedData: SongResult = try self.decode(from: data)
                    self.songResult = parsedData.results
                               // Handle the parsed data
                    onCompletion()
                } catch {
                    print("Error decoding data: \(error)")
                }
            case .failure(let error):
                print("error \(error)")
            }
        }
    }
    
    func getNumOfRows() -> Int {
        return songResult.count
    }

}
