//
//  MusicAppUITests.swift
//  MusicAppUITests
//
//  Created by STARK on 6.06.2023.
//

import XCTest

final class MusicAppUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("---UITest---")
    }
    
    private func search(){
        app.launch()
        
        app.searchFields["Search Artist, Song..."].tap()
        app.searchFields.firstMatch.typeText("Tarkan")
        app.keyboards.buttons["Ara"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Beni Çok Sev"]/*[[".cells.staticTexts[\"Beni Çok Sev\"]",".staticTexts[\"Beni Çok Sev\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    private func loveTapped(){
        let loveButton = app.buttons["love"]
        loveButton.tap()
    }
    
    func testLibraryButton() throws {
        let app = XCUIApplication()
        app.navigationBars["MusicApp.HomeView"].buttons["Library"].tap()
        app.navigationBars["MusicApp.FavouritesView"].buttons["left arrow"].tap()
    }
    
    func testFavouriteAdd() throws {
        search()
        loveTapped()
    }
    
    func testFavouriteDelete() throws {
        search()
        loveTapped()
        loveTapped()
        app.alerts["Attention"].scrollViews.otherElements.buttons["Yes"].tap()
        app.navigationBars["MusicApp.DetaillView"].buttons["left arrow"].tap()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
