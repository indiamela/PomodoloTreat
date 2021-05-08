//
//  Persistence.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/02.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<6 {
            let newTask = TaskEntity(context: viewContext)
            newTask.id = UUID().uuidString
            newTask.title = "読書"
            newTask.memo = "いっぱい読んだ"
            newTask.motivation = 60
            newTask.start_time = Date()
            newTask.end_time = Date()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PomodoloTreat")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
