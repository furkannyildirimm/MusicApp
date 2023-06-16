//
//  MusicCellPresenterTest.swift
//  MusicAppTests
//
//  Created by STARK on 16.06.2023.
//

import XCTest
import SDWebImage
@testable import MusicApp
@testable import MusicAPI

final class MusicCellPresenterTest: XCTestCase {
    
    var view: MockMusicCell!
    var music: Music!
    var presenter: MusicCellPresenter!
    
    override func setUp() {
        super.setUp()
        view = .init()
        music = Music(artistId: 0, collectionId: 0, trackId: 0, artistName: "", collectionName: "", trackName: "", collectionCensoredName: "", trackCensoredName: "", artistViewUrl: "", collectionViewUrl: "", trackViewUrl: "", previewUrl: "", artworkUrl30: "", artworkUrl60: "", artworkUrl100: "", collectionPrice: 0.0, trackPrice: 0.0, primaryGenreName: "")
        presenter = .init(view: view, music: music)
    }
    
    override func tearDown() {
        presenter = nil
        view = nil
    }
    
    func test_Load() {
        XCTAssertFalse(view.isInvokedSetArtist)
        XCTAssertEqual(view.invokedSetupSetArtistCount, 0)
        XCTAssertNil(view.isInvokedSetArtistParameters)
        
        XCTAssertFalse(view.isInvokedSetTitle)
        XCTAssertEqual(view.invokedSetupSetTitleCount, 0)
        XCTAssertNil(view.isInvokedSetTitleParameters)
        
        
        presenter.load()
        
        XCTAssertTrue(view.isInvokedSetArtist)
        XCTAssertEqual(view.invokedSetupSetArtistCount, 1)
        XCTAssertEqual(view.isInvokedSetArtistParameters?.text, music.artistName)
        
        XCTAssertTrue(view.isInvokedSetTitle)
        XCTAssertEqual(view.invokedSetupSetTitleCount, 1)
        XCTAssertEqual(view.isInvokedSetTitleParameters?.text, music.trackName!)
        
    }
}
