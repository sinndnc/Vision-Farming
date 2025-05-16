//
//  CoreDataStack.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/21/25.
//


import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData yüklenemedi: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        context.perform {
            if self.context.hasChanges {
                do {
                    try self.context.save()
                } catch {
                    Logger.log("CoreData Kaydedilemedi: \(error)")
                }
            }
        }
    }
}
