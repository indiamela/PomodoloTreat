//
//  PomodoloTreatApp.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/02.
//

import SwiftUI

@main
struct PomodoloTreatApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
