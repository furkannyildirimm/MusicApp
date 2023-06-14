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
    
    func search(){
        app.launch()
        app.searchFields["Search Artist, Song..."].tap()
        
        let tKey = app/*@START_MENU_TOKEN@*/.keys["T"]/*[[".keyboards.keys[\"T\"]",".keys[\"T\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(tKey.exists)
        tKey.tap()
        
        
        let aKey = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(aKey.exists)
        aKey.tap()
        
        
        let rKey = app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(rKey.exists)
        rKey.tap()
        
        
        let kKey = app/*@START_MENU_TOKEN@*/.keys["k"]/*[[".keyboards.keys[\"k\"]",".keys[\"k\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(kKey.exists)
        kKey.tap()
        
        XCTAssertTrue(aKey.exists)
        aKey.tap()
        
        let nKey = app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(nKey.exists)
        nKey.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Beni Çok Sev"]/*[[".cells.staticTexts[\"Beni Çok Sev\"]",".staticTexts[\"Beni Çok Sev\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func loveTapped(){
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
