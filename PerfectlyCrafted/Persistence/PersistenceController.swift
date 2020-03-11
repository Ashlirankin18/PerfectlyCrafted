//
//  PersistenceController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/8/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit
import CoreData

/// Handle the applications persistence logic
final class PersistenceController {
    
    private let modelName: String
    
    lazy var mainContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    /// Creates a new instance of the `PersistenceController`
    /// - Parameter modelName: The name of the xcDataModel file.
    init(modelName: String) {
        self.modelName = modelName
    }
}

extension PersistenceController {
    
    /// Saves any chages to the main/ parent context.
    func saveContext () {
        guard mainContext.hasChanges else {
            return
        }
        do {
            try mainContext.save()
        } catch let nserror as NSError {
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
