//
//  MusicAppTests.swift
//  MusicAppTests
//
//  Created by  ST on 3/29/23.
//

import XCTest
@testable import MusicApp
import AVFoundation
import AVFAudio

final class MusicAppTests: XCTestCase {
    var mockApi: API?
    var apiHandler: APIHandler?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testApiUrl(){
        let actualURL =  URL(string:"https://itunes.apple.com/search?term=metallica")
        let testedURL = API.searchURL(for: "metallica")
        XCTAssertEqual(actualURL, testedURL)
        
        let actualURL2 =  URL(string:"https://itunes.apple.com/search?term=metallica")
        let testedURL2 = API.searchURL(for: "metallicas")
        XCTAssertNotEqual(actualURL2, testedURL2)
       
        let actualURL3 =  URL(string:"https://itunes.apple.com/search?term=JustinBieber")
        let testedURL3 = API.searchURL(for: "Justin Bieber")
        XCTAssertNotEqual(actualURL3, testedURL3)
    }
    func testFetchApi(){
        let url = API.searchURL(for: "Justin Bieber")
        APIHandler.shared.fetchAPI(url: url!){ result in
            switch result {
            case .failure (let error):
                XCTAssertNotNil(error)
            case .success(let data):
                XCTAssertNotNil(data)
            }
        }
        
        let url2 = API.searchURL(for: "Nirvana")
        APIHandler.shared.fetchAPI(url: url!){ result in
            switch result {
            case .failure (let error):
                XCTAssertNotNil(error)
            case .success(let data):
                XCTAssertNotNil(data)
            }
        }
    }
    
    func testGetSongDuration(){
        let urlString = "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/40/64/66/40646668-82fe-e7f4-6e09-1194fb0ced89/mzaf_7480774833552227899.plus.aac.p.m4a"
        var player: AVPlayer
        let previewURL = URL(string: urlString)!
        
        let playerItem = AVPlayerItem(url: previewURL)
        player = AVPlayer(playerItem: playerItem)
        
        
        
    }
    

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
