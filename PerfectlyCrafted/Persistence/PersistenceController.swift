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
    
    lazy var viewContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    /// Creates a new context bound to a background queue.
    var newBackgroundContext: NSManagedObjectContext {
        let backgroundContext = storeContainer.newBackgroundContext()
        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        return backgroundContext
    }
    
    /// Creates a new context bound to the main queue.
    var newMainContext: NSManagedObjectContext {
        let mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.persistentStoreCoordinator = viewContext.persistentStoreCoordinator
        mainContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        return mainContext
    }
    
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
        viewContext.automaticallyMergesChangesFromParent = true
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }
}

extension PersistenceController {
    
    func retrieveObject(with identifier: UUID, on context: NSManagedObjectContext) -> Post? {
        let post = retrieveObjects(with: identifier, context: context).first { (post) -> Bool in
            post.id == identifier
        }
        return post
    }
    
    func retrieveObjects(with identifier: UUID, context: NSManagedObjectContext) -> [Post] {
        let fetchRequest = NSFetchRequest<Post>()
        fetchRequest.entity = Post.entity()
        fetchRequest.predicate = NSPredicate(format: "id == %@", identifier.description)
       
        do {
            let objects = try context.fetch(fetchRequest)
            return objects
        } catch {
            logAssertionFailure(message: "Unable to retrieve objects with specified identifier")
            return []
        }
   }
    
    func deleteObject(with identifier: UUID, on context: NSManagedObjectContext) {
        guard let post = retrieveObject(with: identifier, on: context) else {
            logAssertionFailure(message: "Could not retrieve post.")
            return
        }
        context.delete(post)
        saveContext(context: context)
    }
}

extension PersistenceController {
    
    /// Saves any chages to the main/ parent context.
    func saveContext(context: NSManagedObjectContext) {
        guard context.hasChanges else {
            return
        }
        do {
            try context.save()
        } catch let nserror as NSError {
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
