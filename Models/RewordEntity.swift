//
//  RewordEntity.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/14.
//

import Foundation
import SwiftUI
import CoreData

extension RewordEntity{
    static func create(in managedObjectContext: NSManagedObjectContext,
                       id:String = UUID().uuidString,
                       title: String = ""
    ){
        let newReword = self.init(context: managedObjectContext)
        newReword.id = UUID().uuidString
        newReword.title = title
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
