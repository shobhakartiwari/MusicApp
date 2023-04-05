//
//  ApiHandler.swift
//  MusicApp
//
//  Created by  ST on 3/29/23.
//

import Foundation


class APIHandler{
    static let shared: APIHandler = APIHandler()
    
    func fetchAPI(url: URL, completion: @escaping (Result<Data, Error>) -> ()) {
        print("calling api")
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("No data")
                completion(.failure(error!))
                return
            }
            print("there is data")
            completion(.success(data))
        }.resume()
    }

    
    
}
