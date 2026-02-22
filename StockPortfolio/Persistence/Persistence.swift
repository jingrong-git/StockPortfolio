//
//  Persistence.swift
//  StockPortfolio
//
//  Created by Jingrong Zhou on 2/18/26.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "StockPortfolio")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData error: \(error)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
