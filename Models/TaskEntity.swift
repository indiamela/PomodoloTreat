//
//  TaskEntity.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/06.
//

import Foundation
import SwiftUI
import CoreData

extension TaskEntity{
    static func create(in managedObjectContext: NSManagedObjectContext,
                       id:String = UUID().uuidString,
                       title: String = "",
                       memo: String = "",
                       motivation: Double = 0.0,
                       start_time: Date = Date(),
                       end_time: Date? = Date(),
                       minute: Int? = 0
    ){
        let calendar = Calendar(identifier: .gregorian)
        
        let newTask = self.init(context: managedObjectContext)
        newTask.id = UUID().uuidString
        newTask.title = title
        newTask.memo = memo
        newTask.motivation = motivation
        newTask.start_time = start_time
        if newTask.end_time != nil{
            newTask.end_time = end_time
        } else {
            newTask.end_time = calendar.date(byAdding: DateComponents(minute: minute), to: start_time)!
        }
        withAnimation {
            do {
                try managedObjectContext.save()
            }catch{
                let nserror = error as NSError
                fatalError("error\(nserror),\(nserror.userInfo)")
            }
        }
    }
}

//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()
