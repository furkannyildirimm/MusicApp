//
//  CoreDataManager.swift
//  MusicApp
//
//  Created by STARK on 11.06.2023.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func saveMusicDetails(music1: MusicDetails)
    func deleteMusic(music: MusicDetails)
    func checkIfMusicExists(music: MusicDetails) -> Bool
    func fetchMusic() -> [MusicDetails]
}

struct MusicDetails {
    var artistName: String
    var collectionName: String
    var trackName: String
    var artworkUrl100: String
    var trackId: Int
}

class CoreDataManager: CoreDataManagerProtocol {
    static let shared = CoreDataManager()
    var isMusicSaved: Bool = false
    
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MusicApp")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error {
                fatalError("CoreData yüklenemedi: \(error)")
            }
        })
        return container
    }()
    
    func saveMusicDetails(music1: MusicDetails) {
        if isMusicSaved {
            print("Bu müzik zaten kaydedilmiş.")
            return
        }
        
        let existingMusic = CoreDataManager.shared.fetchMusic().first { music in
            return music.trackId == music1.trackId
        }
        
        if existingMusic != nil {
            print("Bu müzik zaten kaydedilmiş.")
        } else {
            CoreDataManager.shared.saveMusic(music: music1)
            isMusicSaved = true
            print("Müzik başarıyla kaydedildi.")
        }
    }
    
    func deleteMusic(music: MusicDetails) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<MusicEntity> = MusicEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "artistName == %@ AND collectionName == %@ AND trackName == %@", music.artistName, music.collectionName, music.trackName)
        
        do {
            let musicEntities = try context.fetch(fetchRequest)
            for music in musicEntities {
                context.delete(music)
            }
            
            try context.save()
        } catch {
            print("Müzik silinemedi: \(error)")
        }
    }
    func checkIfMusicExists(music: MusicDetails) -> Bool {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<MusicEntity> = MusicEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "artistName == %@ AND collectionName == %@ AND trackName == %@", music.artistName, music.collectionName, music.trackName)
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Müzik sorgulanamadı: \(error)")
            return false
        }
    }
    
    func saveMusic(music: MusicDetails) {
        let context = persistentContainer.viewContext
        let musicEntity = MusicEntity(context: context)
        musicEntity.artistName = music.artistName
        musicEntity.collectionName = music.collectionName
        musicEntity.trackName = music.trackName
        musicEntity.artworkUrl100 = music.artworkUrl100
        do {
            try context.save()
        } catch {
            print("Müzik kaydedilemedi: \(error)")
        }
    }
    
    func fetchMusic() -> [MusicDetails] {
        
        var musicEntity: [MusicDetails] = []
        
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MusicEntity")
        
        do {
            let musicEntities = try context.fetch(fetchRequest)
            for result in musicEntities as! [NSManagedObject] {
                
                let artistName = result.value(forKey: "artistName") as? String
                let trackId = result.value(forKey: "trackId") as? Int
                let trackName = result.value(forKey: "trackName") as? String
                let collectionName = result.value(forKey: "collectionName") as? String
                let artworkUrl100 = result.value(forKey: "artworkUrl100") as? String
                
                musicEntity.append(
                    MusicDetails(artistName: artistName ?? "", collectionName: collectionName ?? "", trackName: trackName ?? "", artworkUrl100: artworkUrl100 ?? "", trackId: trackId ?? 0)
                )
            }
        } catch {
            print("Müzik alınamadı: \(error)")
            return []
        }
        return musicEntity
    }
}


