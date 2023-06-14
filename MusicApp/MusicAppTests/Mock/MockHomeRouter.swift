//
//  MockHomeRouter.swift
//  MusicAppTests
//
//  Created by STARK on 13.06.2023.
//

import Foundation
@testable import MusicApp

final class MockHomeRouter: HomeRouterProtocol {
    
    var isInvokedNavigate = false
    var invokedNavigateCount = 0
    var invokedNavigateParameters: (route: HomeRoutes, Void)?
    
    func navigate(_ route: MusicApp.HomeRoutes) {
        isInvokedNavigate = true
        invokedNavigateCount += 1
        invokedNavigateParameters = (route, ())
    }
}
