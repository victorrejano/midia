//
//  StorageManager.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 3/11/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import UIKit

class StorageManager {

    //static let shared: FavoritesProvidable = UserDefaultStorageManager(withMediaItemKind: .movie)
    static var shared: FavoritesProvidable {
      
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return CoreDataStorageManager(withMediaItemKind: appDelegate.currentMediaItemKind)
    }
}
