//
//  CoreDataStorageManager.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 3/12/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation
import CoreData

// TODO: capa de abstraction para usar siempre media items

final class CoreDataStorageManager {

    let mediaItemKind: MediaItemKind
    let favoritesProvidable: FavoritesProvidable
    
    init(withMediaItemKind mediaItemKind: MediaItemKind) {
        self.mediaItemKind = mediaItemKind
        
        switch mediaItemKind {
        case .book:
            favoritesProvidable = BookFavoritesProvidable()
        case .movie:
            favoritesProvidable = MovieFavoritesProvidable()
        default:
            fatalError("Not implemented yet")
        }
    }
}

extension CoreDataStorageManager: FavoritesProvidable {
    func getFavorites() -> [MediaItemDetailedProvidable]? {
        return favoritesProvidable.getFavorites()
    }
    
    func getFavorite(byId favoriteId: String) -> MediaItemDetailedProvidable? {
        return favoritesProvidable.getFavorite(byId:favoriteId)
    }
    
    func add(favorite: MediaItemDetailedProvidable) {
        return favoritesProvidable.add(favorite: favorite)
    }
    
    func remove(favoriteWithId favoriteId: String) {
        return favoritesProvidable.remove(favoriteWithId: favoriteId)
    }
    
    
}


