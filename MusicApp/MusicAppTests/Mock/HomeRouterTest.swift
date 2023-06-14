//
//  HomeRouterTest.swift
//  MusicAppTests
//
//  Created by STARK on 14.06.2023.
//


import XCTest
@testable import MusicApp
import MusicAPI

class RouterTests: XCTestCase {
    
    var mockRouter: MockHomeRouter!
    
    override func setUp() {
        super.setUp()
        mockRouter = .init()
    }
    
    override func tearDown() {
        mockRouter = nil
        super.tearDown()
    }
    
    func testNavigateToDetail() {
        XCTAssertFalse(mockRouter.isInvokedNavigate)
        XCTAssertEqual(mockRouter.invokedNavigateCount, 0)
        //XCTAssertNil(mockRouter.invokedNavigateParameters)
        
        let route: HomeRoutes = .favourites
        mockRouter.navigate(route)
        
        XCTAssertTrue(mockRouter.isInvokedNavigate)
        XCTAssertEqual(mockRouter.invokedNavigateCount, 1)
        //XCTAssertEqual(mockRouter.invokedNavigateParameters?.route, route)
    }
}
