//
//  Constants.swift
//  MusicApp
//
//  Created by  ST on 3/29/23.
//

import Foundation

struct API {
    static private let url = "https://itunes.apple.com"
    static private let path = "/search?term="
    
    static func searchURL(for artistName: String) -> URL? {
        let formattedName = artistName.replacingOccurrences(of: " ", with: "+")
        return URL(string: url + path + formattedName)
    }
}


