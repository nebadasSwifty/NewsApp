//
//  NSManagedObject+Ext.swift
//  NewsApp
//
//  Created by Кирилл on 22.09.2022.
//

import Foundation
import CoreData

extension NSManagedObject {
    class func deleteEntity(_ entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        do {
            let object = try DatabaseService.shared.context.fetch(fetchRequest) as! [NSManagedObject]
            
            object.forEach({ DatabaseService.shared.context.delete($0)} )
        } catch {
            print("Can't clear entity. Entity name: \(entity)")
        }
    }
    
    class func fetchAll<T>(_ entityName: String, sortDescriptors: [NSSortDescriptor]? = nil, list: inout [T], limit: Int = 0) {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            fetchRequest.sortDescriptors = sortDescriptors
            
            do {
                list = try DatabaseService.shared.context.fetch(fetchRequest) as! [T]
            } catch {
                print("error while getting \(entityName): \(error)")
            }
        }
}


extension NSPersistentStoreCoordinator {
    public enum PersistentStoreErrors: Error {
        case modelFileNotFound
        case modelCreationError
    }
    
    static func coordinator(name: String) throws -> NSPersistentStoreCoordinator? {
        guard let modelURL = Bundle.main.url(forResource: name, withExtension: "momd") else {
            throw PersistentStoreErrors.modelFileNotFound
        }
        
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            throw PersistentStoreErrors.modelCreationError
        }
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        let fileManager = FileManager.default
        
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        do {
            let url = documentsDirectory.appendingPathComponent("\(name).sqlite")
            let options = [
                NSMigratePersistentStoresAutomaticallyOption: true,
                NSInferMappingModelAutomaticallyOption: true
            ]
            
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            throw error
        }
        
        return coordinator
    }
    
}
