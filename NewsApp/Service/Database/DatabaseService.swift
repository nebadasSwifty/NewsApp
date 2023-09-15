//
//  DatabaseService.swift
//  NewsApp
//
//  Created by Кирилл Сутормин on 15.09.2023.
//

import CoreData
import UIKit

class DatabaseService {
    static let shared = DatabaseService()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        do {
            return try NSPersistentStoreCoordinator.coordinator(name: "NewsCoreData")
        } catch {
            print("Can't create persistentStoreCoordinator")
        }
        
        return nil
    }()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewsCoreData")
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private lazy var managedObjectContext: NSManagedObjectContext = {
        let coodinator = persistentStoreCoordinator
        
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coodinator
        
        return managedObjectContext
    }()
    
    var context: NSManagedObjectContext {
        return managedObjectContext
    }
    
    private init() {}
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = context
        
        if context.hasChanges {
            do {
                try context.save()
                print("Changes in CoreData")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    @discardableResult
    func parseToDatabase<T: Parsable, U: Decodable>(with elements: [U], for entity: String) -> [T] {
        var result: [T] = []
        
        elements.forEach({ element in
            if let entity = NSEntityDescription.insertNewObject(forEntityName: entity, into: self.context) as? T {
                if let resultElement = entity.parse(element as? T.Element) {
                    result.append(resultElement)
                }
            }
        })
        
        return result
    }
}
