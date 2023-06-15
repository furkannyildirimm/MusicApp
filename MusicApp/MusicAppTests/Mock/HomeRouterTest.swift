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
        
        let router = MockHomeRouter()
        XCTAssertFalse(router.isInvokedNavigate)
        XCTAssertEqual(router.invokedNavigateCount, 0)
        
        router.navigate(.detail(source: nil))
        
        XCTAssertTrue(router.isInvokedNavigate)
        XCTAssertEqual(router.invokedNavigateCount, 1)
        if case .detail = router.invokedNavigateParameters?.route {
        } else {
            XCTFail("Route is not .detail")
        }
    }
    
    func testNavigateToFavourite() {
        
        let router = MockHomeRouter()
        XCTAssertFalse(router.isInvokedNavigate)
        XCTAssertEqual(router.invokedNavigateCount, 0)
        
        router.navigate(.favourites)
        
        XCTAssertTrue(router.isInvokedNavigate)
        XCTAssertEqual(router.invokedNavigateCount, 1)
        if case .favourites = router.invokedNavigateParameters?.route {
        } else {
            XCTFail("Route is not .favourites")
        }
    }
}
