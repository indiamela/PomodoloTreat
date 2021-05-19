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
    let persistenceController = PersistenceController.preview

    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(TimerManager())
            }
        }
    }
}
