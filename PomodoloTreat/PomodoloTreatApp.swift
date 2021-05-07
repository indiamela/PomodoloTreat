//
//  PomodoloTreatApp.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/02.
//

import SwiftUI
import CoreData

@main
struct PomodoloTreatApp: App {
    // Create the SwiftUI view and set the context as the value for the managedObjectContext environment keyPath.
    // Add `@Environment(\.managedObjectContext)` in the views that will need the context.
//    let persistenceController = PersistenceController.shared
//    @Environment(\.managedObjectContext) private var viewContext
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name:"TaskEntity")
        container.loadPersistentStores(
            completionHandler: {(storeDescription,error) in
                if let error = error as NSError?{
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            }
        )
        return container
    }()
    
    func saveContext(){
        let context = persistentContainer.viewContext
        if context.hasChanges{
            do{
                try context.save()
            } catch{
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
//                    .environment(\.managedObjectContext, persistentContainer.viewContext)
            }
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
