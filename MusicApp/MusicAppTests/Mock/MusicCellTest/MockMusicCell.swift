//
//  MockMusicCell.swift
//  MusicAppTests
//
//  Created by STARK on 16.06.2023.
//

import Foundation
@testable import MusicApp
import MusicAPI

final class MockMusicCell: MusicCellProtocol {
    
    var isInvokedSetImage = false
    var invokedSetupSetImage = 0
    var isInvokedSetImageParameters: (url: URL, Void)?
    
    func setImage(_ url: URL) {
        isInvokedSetImage = true
        invokedSetupSetImage += 1
        isInvokedSetImageParameters = (url, ())
    }
    
    var isInvokedSetTitle = false
    var invokedSetupSetTitleCount = 0
    var isInvokedSetTitleParameters: (text: String, Void)?
    
    func setTitle(_ text: String) {
        isInvokedSetTitle = true
        invokedSetupSetTitleCount += 1
        isInvokedSetTitleParameters = (text, ())
    }
    
    var isInvokedSetArtist = false
    var invokedSetupSetArtistCount = 0
    var isInvokedSetArtistParameters: (text: String, Void)?
    
    func setArtist(_ text: String) {
        isInvokedSetArtist = true
        invokedSetupSetArtistCount += 1
        isInvokedSetArtistParameters = (text, ())
    }
    
    var isInvokedSetCollection = false
    var invokedSetupSetCollection = 0
    var isInvokedSetCollectionParameters: (text: String, Void)?
    
    func setCollection(_ text: String) {
        isInvokedSetCollection = true
        invokedSetupSetCollection += 1
        isInvokedSetCollectionParameters = (text, ())
    }
    
    var isInvokedcellReloadData = false
    var invokedSetupcellReloadData = 0
    
    func cellReloadData() {
        isInvokedcellReloadData = true
        invokedSetupcellReloadData += 1
    }
    
    
}
