//
//  Reachability.swift
//  MusicApp
//
//  Created by STARK on 6.06.2023.
//

import Alamofire

final class Reachability {
    class func isConnectedToNetwork() -> Bool {
        NetworkReachabilityManager()?.isReachable ?? false
    }
}
