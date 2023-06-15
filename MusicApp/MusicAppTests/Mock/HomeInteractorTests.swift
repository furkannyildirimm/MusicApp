//
//  HomeInteractorTests.swift
//  MusicAppTests
//
//  Created by STARK on 15.06.2023.
//

import XCTest
@testable import MusicApp
import MusicAPI

final class HomeInteractorTests: XCTestCase {
    
    var mockInteractor: MockHomeInteractor!
    
    override func setUp() {
        super.setUp()
        mockInteractor = .init()
    }
    
    override func tearDown() {
        mockInteractor = nil
        super.tearDown()
    }
    
    func testFetchMusic() {
        XCTAssertFalse(mockInteractor.fetchMusicCalled)
        XCTAssertNil(mockInteractor.fetchMusicKeyword)
        
        let keyword = "tarkan"
        mockInteractor.fetchMusic(with: keyword)
        
        XCTAssertTrue(mockInteractor.fetchMusicCalled)
        XCTAssertEqual(mockInteractor.fetchMusicKeyword, keyword)
    }
}

