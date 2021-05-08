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
    let persistenceController = PersistenceController.shared
//    @Environment(\.managedObjectContext) private var viewContext

    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
