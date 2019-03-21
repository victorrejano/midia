//
//  StorageManager.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 3/11/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

class StorageManager {

    static let shared: FavoritesProvidable = UserDefaultStorageManager(withMediaItemKind: .movie)
    //static let shared: FavoritesProvidable = CoreDataStorageManager(withMediaItemKind: .book)

}
