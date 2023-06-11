//
//  CoreDataManager.swift
//  MusicApp
//
//  Created by STARK on 11.06.2023.
//

import Foundation
import CoreData

struct MusicDetails {
    var artistName: String
    var collectionName: String
    var trackName: String
    var artworkUrl100: String
    
}

class CoreDataManager {
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
    
    func saveMusicDetails(music: MusicDetails) {
        if isMusicSaved {
            print("Bu müzik zaten kaydedilmiş.")
            return
        }
        
        let existingMusic = CoreDataManager.shared.fetchMusic().first { music in
            return music.trackId == music.trackId
        }
        
        if existingMusic != nil {
            print("Bu müzik zaten kaydedilmiş.")
        } else {
            CoreDataManager.shared.saveMusic(music: music)
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
    
    func fetchMusic() -> [MusicEntity] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<MusicEntity> = MusicEntity.fetchRequest()
        
        do {
            let musicEntities = try context.fetch(fetchRequest)
            return musicEntities
        } catch {
            print("Müzik alınamadı: \(error)")
            return []
        }
    }
}

