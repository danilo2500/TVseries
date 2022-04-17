//
//  CoreDataManager.swift
//  TVSeries
//
//  Created by Danilo Henrique on 17/04/22.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    let appDelegate = UIApplication.shared.appDelegate
    lazy var managedContext = appDelegate.persistentContainer.viewContext
    
    func save(object: NSManagedObject, completion: (Error?) -> Void) {
        do {
            try managedContext.save()
            completion(nil)
        } catch let error as NSError {
            completion(error)
        }
    }
    
    func getAll<T: NSManagedObject>(entityType: T.Type, completion: (Result<[T], Error>) -> Void) {
        let entityName = String(describing: T.self)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let results = try managedContext.fetch(fetchRequest) as! [T]
            completion(.success(results))
        } catch {
            completion(.failure(error))
        }
    }
    
    func get<T: NSManagedObject>(entityType: T.Type, withId id: Int, completion: (Result<[T], Error>) -> Void) {
        let entityName = String(describing: T.self)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id = %d", id)
        do {
            let results = try managedContext.fetch(fetchRequest) as! [T]
            completion(.success(results))
        } catch {
            completion(.failure(error))
        }
    }
    
    func delete(object: NSManagedObject, completion: ((Error?) -> Void)?) {
        managedContext.delete(object)
        do {
            try managedContext.save()
            completion?(nil)
        } catch {
            completion?(error)
        }
    }
    
    func deleteAllEntries<T: NSManagedObject>(entityType: T.Type, completion: ((Error?) -> Void)?) {
        getAll(entityType: entityType) { (result) in
            switch result {
            case .success(let entities):
                for entity in entities {
                    delete(object: entity, completion: nil)
                }
                completion?(nil)
            case .failure(let error):
                completion?(error)
            }
        }
    }
}
