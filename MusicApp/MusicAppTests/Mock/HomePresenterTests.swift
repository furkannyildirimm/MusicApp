//
//  HomePresenterTests.swift
//  MusicAppTests
//
//  Created by STARK on 13.06.2023.
//

import XCTest
@testable import MusicApp
import MusicAPI

final class HomePresenterTests: XCTestCase {
    
    var presenter: HomePresenter!
    var interactor: MockHomeInteractor!
    var view: MockHomeViewController!
    var router: MockHomeRouter!
    
    override func setUp() {
        super.setUp()
        
        interactor = .init()
        view = .init()
        router = .init()
        presenter = .init(view: view, router: router, interactor: interactor)
    }
    
    override func tearDown() {
        presenter = nil
        interactor = nil
        view = nil
        router = nil
    }
    
    func test_viewDidLoad_InvokesRequiredViewMoethods() {
        
        XCTAssertFalse(view.isInvokedSetupTableView)
        XCTAssertEqual(view.invokedSetupTableViewCount, 0)
    
        presenter.viewDidLoad()
    
        XCTAssertTrue(view.isInvokedSetupTableView)
        XCTAssertEqual(view.invokedSetupTableViewCount, 1)

    }
    
    func test_SearchMusic() {
        
        
        XCTAssertFalse(view.isInvokedShowLoading)
        XCTAssertFalse(interactor.fetchMusicCalled)
        XCTAssertNil(interactor.fetchMusicKeyword)
        
        let keyword = "rock"
        
        presenter.searchMusic(with: keyword)
        XCTAssertTrue(view.isInvokedShowLoading)
        XCTAssertTrue(interactor.fetchMusicCalled)
        XCTAssertEqual(interactor.fetchMusicKeyword, keyword)
    }
    
    func test_fetchMusicOutput() {
        
        XCTAssertFalse(view.isInvokedHideLoading)
        XCTAssertEqual(presenter.numberOfItems(), 0)
        XCTAssertFalse(view.isInvokedReloadData)
        
        presenter.fetchMusicOutput(.success(MusicResult.response.results!))
        
        XCTAssertTrue(view.isInvokedHideLoading)
        XCTAssertEqual(presenter.numberOfItems(), 50)
        XCTAssertTrue(view.isInvokedReloadData)
    }
}

extension MusicResult {
    
    static var response: MusicResult {
        let bundle = Bundle(for: HomePresenterTests.self)
        let path = bundle.path(forResource: "Music", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let response = try! JSONDecoder().decode(MusicResult.self, from: data)
        return response
    }
}
