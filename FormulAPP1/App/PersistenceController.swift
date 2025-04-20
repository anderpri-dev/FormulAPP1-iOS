//
//  Persistence.swift
//  FormulAPP1
//
//  Created by ANDER on 20/4/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    @MainActor
    static let preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let context = controller.container.viewContext
        return controller
    }()

    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {

        container = NSPersistentContainer(name: "FormulAPP1")
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        } else {
            // Usamos App Group para compartir la base de datos con el widget
            if let groupURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.es.upsa.mimo.FormulAPP1") {
                let storeURL = groupURL.appendingPathComponent("FormulAPP1.sqlite")
                container.persistentStoreDescriptions.first?.url = storeURL
                print("📂 Usando App Group para la base de datos: \(storeURL)")
            } else { 
                fatalError("❌ Error al buscar el App Group")
            }
        }
        
        // Cargamos el store
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("❌ Error al cargar el store de Core Data: \(error), \(error.userInfo)")
            }
        }
    }
}
