//
//  CoreDataStack.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 3/12/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {

    static let sharedInstance = CoreDataStack()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Error loading persistent stores: \(error)")
            }
        })
        return container
    }()

}
