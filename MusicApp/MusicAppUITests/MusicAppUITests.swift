//
//  MusicAppUITests.swift
//  MusicAppUITests
//
//  Created by STARK on 6.06.2023.
//

import XCTest

final class MusicAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearcbar() throws {
        
        
        let app = XCUIApplication()
        app.navigationBars["MusicApp.HomeView"].buttons["Library"].tap()
        app.navigationBars["MusicApp.FavouritesView"].buttons["left arrow"].tap()
                        
       
    }
    
    func testFavouriteAdd() throws {
        
        let app = XCUIApplication()
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
        
        let loveButton = app.buttons["love"]
        loveButton.tap()
        loveButton.tap()
        app.alerts["Onay"].scrollViews.otherElements.buttons["Evet"].tap()
        app.navigationBars["MusicApp.DetaillView"].buttons["left arrow"].tap()
        
    }
    
    func testFavouriteDelete() throws {
        
                
                
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
