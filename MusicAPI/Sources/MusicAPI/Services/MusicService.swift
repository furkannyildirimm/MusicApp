//
//  File.swift
//  
//
//  Created by STARK on 6.06.2023.
//

import Foundation
import Alamofire

public protocol MusicServiceProtocol: AnyObject {
    func fetchMusicEntries(word: String, completion: @escaping (Result<[Music], Error>) -> Void)
}

public class MusicService: MusicServiceProtocol {
    
    public init() {}
    
    public func fetchMusicEntries(word: String, completion: @escaping (Result<[Music], Error>) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=\(word)&country=tr&entity=song&attribute=mixTerm"
        AF.request(urlString).responseData { response in
            switch response.result {
                
            case .success(let data):
                let decoder = Decoders.dateDecoder
                
                do{
                    let response = try decoder.decode(MusicResponse.self, from: data)
                    completion(.success(response.results))
                } catch {
                    print("JSON ERROR")
                }
            case .failure(let error):
                print("Hata Oluştu: \(error.localizedDescription)")
            }
        }
    }
}


//public func fetchMusicEntries(word: String, completion: @escaping (Result<[Music], Error>) -> Void) {
//    let cleanedWord = word.replacingOccurrences(of: "ı", with: "i")
//                          .replacingOccurrences(of: "ö", with: "o")
//                          .replacingOccurrences(of: "ü", with: "u")
//                          .replacingOccurrences(of: "ş", with: "s")
//                          .replacingOccurrences(of: "ç", with: "c")
//                          .replacingOccurrences(of: "ğ", with: "g")
//                          .lowercased()
//
//    let encodedWord = cleanedWord.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//    let urlString = "https://itunes.apple.com/search?term=\(encodedWord)&country=tr&entity=song&attribute=artistTerm"
//
//    AF.request(urlString).responseData { response in
//        switch response.result {
//        case .success(let data):
//            let decoder = Decoders.dateDecoder
//
//            do {
//                let response = try decoder.decode(MusicResponse.self, from: data)
//                completion(.success(response.results))
//            } catch {
//                print("JSON ERROR")
//            }
//        case .failure(let error):
//            print("Hata Oluştu: \(error.localizedDescription)")
//        }
//    }
//}


