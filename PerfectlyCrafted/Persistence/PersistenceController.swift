//
//  PersistenceController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/8/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit
import CoreData

class PersistenceController {
    
    private let modelName: String
    
    
    lazy var mainContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    lazy var storeContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: self.modelName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    init(modelName: String) {
        self.modelName = modelName
    }
}

extension PersistenceController {
    func saveContext () {
      guard mainContext.hasChanges else { return }

      do {
        try mainContext.save()
      } catch let nserror as NSError {
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
}
