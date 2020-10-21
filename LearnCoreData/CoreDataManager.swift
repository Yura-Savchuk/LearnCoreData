//
//  CoreDataManager.swift
//  LearnCoreData
//
//  Created by Yura Savchuk on 07.09.2020.
//  Copyright © 2020 Yura Savchuk. All rights reserved.
//

import CoreData

class CoreDataManager {
    
    static var shared: CoreDataManager = {
        return CoreDataManager(modelName: "LearnCoreData")
    }()
    
    private let modelName: String
    
    private init(modelName: String) {
        self.modelName = modelName
    }
    
    private lazy var managedObjectModel: NSManagedObjectModel? = {
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            return nil
        }
        return NSManagedObjectModel(contentsOf: modelURL)
    }()
    
    private lazy var persistentStoreContainer: NSPersistentContainer? = {
        guard let managedObjectModel = self.managedObjectModel else {
            return nil
        }
        let container = NSPersistentContainer(name: self.modelName, managedObjectModel: managedObjectModel)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private(set) lazy var mainContext: NSManagedObjectContext? = {
        guard let persistentStoreCoordinator = self.persistentStoreContainer?.persistentStoreCoordinator else {
            return nil
        }
        
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        return context
    }()

}
